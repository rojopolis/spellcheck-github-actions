---
name: dockerfile-reviewer
description: Review Dockerfile changes for security, layer caching efficiency, and completeness of language package pairs (aspell/hunspell parity)
---

When reviewing changes to the Dockerfile, check:

1. **Package parity**: every `aspell-XX` package must have a matching `hunspell-XX` package (the action supports both spellcheckers). Flag any language that is present in one but not the other.

2. **Base image pinning**: the `FROM` line must pin a specific digest (`@sha256:...`), not just a tag. Floating tags like `latest` or `3.14-slim` are not acceptable.

3. **apt-get best practices**:
   - All `apt-get install` calls should be in a single `RUN` layer combined with `apt-get update`
   - Should end with `apt-get clean && rm -rf /var/lib/apt/lists/*` to reduce image size
   - Consider `--no-install-recommends` for packages that don't need optional dependencies

4. **Python dependency consistency**: confirm that versions in `requirements.txt` are fully pinned and that `constraint.txt` does not conflict with them.

5. **Security**: flag any packages with known CVEs if detectable from the package name and version context.

Produce a concise report: list each issue found with the line number and a one-line explanation. If everything looks good, say so explicitly.
