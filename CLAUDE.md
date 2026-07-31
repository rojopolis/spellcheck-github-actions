# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

A GitHub Action that spell checks Python, Markdown, and Text files using [PySpelling](https://facelessuser.github.io/pyspelling/). The action runs inside a Docker container (`jonasbn/github-action-spellcheck`) and is published to GitHub Marketplace and DockerHub.

## Architecture

The action has three core components that work together:

1. **`entrypoint.sh`** — the Docker `ENTRYPOINT`. Reads action inputs (passed as `INPUT_*` env vars), discovers the spellcheck config file, builds and runs the `pyspelling` CLI command. Handles source file parsing (space/quote-delimited), spell checker selection (`aspell`/`hunspell`), and optional artifact output.

2. **`pwc.py`** — a Python helper that validates whether a candidate file matches the `sources:` glob patterns in the PySpelling YAML config. Called per-file from `entrypoint.sh` to decide whether to skip files that don't match the configured patterns.

3. **`Dockerfile`** — builds from `python:3.14.x-slim-trixie`, installs aspell/hunspell and all supported language packages via `apt-get`, then installs Python dependencies from `requirements.txt`. The working directory inside the container is `/tmp` (the checked-out repository is mounted there).

**Action inputs** (`action.yml`) map to env vars in the container:
- `config_path` → `INPUT_CONFIG_PATH`
- `source_files` → `INPUT_SOURCE_FILES`
- `task_name` → `INPUT_TASK_NAME`
- `output_file` → `INPUT_OUTPUT_FILE`
- `spell_checker` → `INPUT_SPELL_CHECKER`
- `skip_dict_compile` → `INPUT_SKIP_DICT_COMPILE`

**Config file discovery order** (first match wins): `.spellcheck.yml`, `.spellcheck.yaml`, `spellcheck.yml`, `spellcheck.yaml`, `.pyspelling.yaml`, `.pyspelling.yml`.

## Development Commands

### Build Docker image locally

```bash
docker build -t jonasbn/github-action-spellcheck:local .
```

### Run spellcheck locally (against this repo)

```bash
# Using Docker
docker run -it -v $PWD:/tmp jonasbn/github-action-spellcheck:local

# Against a config at a non-default path (skips discovery order)
docker run -it -v $PWD:/tmp -e INPUT_CONFIG_PATH="path/to/config.yaml" jonasbn/github-action-spellcheck:local

# Using pyspelling directly (requires local install)
pyspelling -c spellcheck.yaml
```

### Inspect what's actually installed in a published image

The published image can lag `requirements.txt` (Docker layer caching, manual DockerHub releases via `scripts/build.pl`). To check the real installed versions rather than trusting the file:

```bash
docker pull jonasbn/github-action-spellcheck:0.x.x   # tag from action.yml
docker run --rm --entrypoint pip3 jonasbn/github-action-spellcheck:0.x.x list
```

### Run tests

Tests use [Bats](https://github.com/bats-core/bats-core) and require the Docker image built as `:local`:

```bash
bats test/test.bats
```

> **Note:** All Bats tests use `-it` (interactive TTY). When run non-interactively (e.g. from a script or CI without a terminal), tests 1–5 fail with "cannot attach stdin to a TTY-enabled container" — this is a pre-existing limitation, not a regression. Use `docker run -v $PWD:/tmp jonasbn/github-action-spellcheck:local` as the reliable non-interactive smoke test.

Run a single test:

```bash
bats --filter "can do basic run using Docker image without any input files" test/test.bats
```

### Lint

```bash
# Markdown linting
markdownlint '**/*.md'

# Shell script linting
shellcheck entrypoint.sh

# Perl linting (scripts in scripts/ and prototypes/)
perlcritic scripts/build.pl
```

### Pre-commit hooks

```bash
pre-commit run --all-files
```

Hooks enforce: trailing whitespace, end-of-file newlines, YAML/JSON validity, sorted `wordlist.txt`, and markdownlint.

### Update Python dependencies

`requirements.txt` is generated from `requirements.in` via [pip-tools](https://github.com/jazzband/pip-tools) — do not hand-edit `requirements.txt` directly, since manual edits to individual transitive pins (e.g. bumping `bracex` without checking what `wcmatch` actually requires) is what caused issue #378.

```bash
pip install pip-tools

# Bump everything to the latest mutually compatible versions
pip-compile requirements.in --output-file=requirements.txt --strip-extras --upgrade

# Bump only specific packages, leaving all other pins untouched
pip-compile requirements.in --output-file=requirements.txt --strip-extras --upgrade-package <name>
```

Run this with the same Python minor version as the Dockerfile's base image (check `FROM python:3.14.x-slim-trixie`) so resolved versions match what actually installs in the container. After regenerating, rebuild the local image and rerun the smoke test to confirm.

## Key Files

- `spellcheck.yaml` — this repo's own PySpelling config (checks `**/*.md`, excludes `venv/`, `CLAUDE.md`, and `.claude/**/*.md`)
- `wordlist.txt` — custom dictionary for this repo's spellcheck (must stay sorted; pre-commit enforces this)
- `constraint.txt` — pip version constraints for reproducible builds
- `requirements.in` — direct Python dependencies (`pyspelling`, `pymdown-extensions`); source of truth for `requirements.txt`
- `requirements.txt` — fully pinned dependency set (direct + transitive) installed in the Docker image, generated from `requirements.in` via `pip-compile` — do not hand-edit
- `dictionary.dic` — aspell dictionary file (binary format, used during image build)
- `examples/` — example PySpelling configurations for Markdown, Python, and plain text

## Releasing

### Credentials

- GHCR (CI): uses `GITHUB_TOKEN` — no PAT required, never expires.
- DockerHub (local): uses your local `docker login` session. Verify it is valid before running `build.pl` (`docker login`).

The Docker image is published via the `docker-build.yml` workflow on push to `master` or on any tag. Tags trigger semver-tagged image builds. The `action.yml` points to a pinned image version (`docker://jonasbn/github-action-spellcheck:0.x.x`) and must be updated manually when releasing a new version.

**Always use the release-prep skill** (`.claude/skills/release-prep/SKILL.md`) when preparing a release. The skill has `disable-model-invocation: true` — it cannot be called via the Skill tool; follow its steps manually. Key points:
- Update `action.yml` image tag and all `uses: rojopolis/spellcheck-github-actions@X.Y.Z` references in `README.md`.
- Do **not** update `@v0` references in `README.md` — these are floating major-version tags and intentionally unpinned.
- Verify a `CHANGELOG.md` entry exists for the version before proceeding.
- Open a **PR** for these changes — do not commit directly to `master`.
- After the PR merges, run `perl scripts/build.pl $VERSION` to tag and push to GitHub and DockerHub.

## Dependabot Gotchas

- Dependabot may propose Python pre-release images (e.g. `3.15.0b2` — `b` = beta). Close these by commenting `@dependabot ignore this minor version` on the PR.
- The pip ecosystem entry in `.github/dependabot.yml` uses `versioning-strategy: lockfile-only`, which expects a `requirements.in` (manifest) + `pip-compile`-generated `requirements.txt` (lockfile) pair. Dependabot will bump transitive pins in `requirements.txt` on schedule but won't touch the exact versions pinned in `requirements.in` — bump those manually when a direct dependency (`pyspelling`, `pymdown-extensions`) needs a deliberate update.

## README YAML Examples

- Inputs under `with:` in workflow YAML examples must be indented 2 spaces relative to `with:`. This has been a recurring source of invalid examples.
- Don't trust a reviewer's (e.g. Copilot's) "this is invalid YAML" claim at face value — verify with `python3 -c "import yaml; yaml.safe_load(open('README.md').read())"` on the extracted block. Same-indentation block sequences (list items aligned with their parent key) are valid YAML even though they look wrong; the real issue is usually inconsistency with this file's convention, not invalidity.

## Working on Open Branches

- Branches behind open PRs may receive direct pushes from the user (e.g. resolving a merge conflict via the GitHub UI) while a session is in progress. A local `git push` can be rejected as a result — `git fetch` and merge (don't force-push) before retrying.
