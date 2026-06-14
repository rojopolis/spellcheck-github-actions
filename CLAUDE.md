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

# Using pyspelling directly (requires local install)
pyspelling -c spellcheck.yaml
```

### Run tests

Tests use [Bats](https://github.com/bats-core/bats-core) and require the Docker image built as `:local`:

```bash
bats test/test.bats
```

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

## Key Files

- `spellcheck.yaml` — this repo's own PySpelling config (checks `**/*.md`, excludes `venv/`, `CLAUDE.md`, and `.claude/**/*.md`)
- `wordlist.txt` — custom dictionary for this repo's spellcheck (must stay sorted; pre-commit enforces this)
- `constraint.txt` — pip version constraints for reproducible builds
- `requirements.txt` — pinned Python dependencies installed in the Docker image
- `dictionary.dic` — aspell dictionary file (binary format, used during image build)
- `examples/` — example PySpelling configurations for Markdown, Python, and plain text

## Releasing

The Docker image is published via the `docker-build.yml` workflow on push to `master` or on any tag. Tags trigger semver-tagged image builds. The `action.yml` points to a pinned image version (`docker://jonasbn/github-action-spellcheck:0.x.x`) and must be updated manually when releasing a new version.
