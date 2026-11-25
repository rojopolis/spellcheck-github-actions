---
name: release-prep
description: Prepare a new release - bump action.yml image version, verify CHANGELOG entry and stage changes
disable-model-invocation: true
---

Args: VERSION (e.g. 0.61.0)

Steps:

1. Update `action.yml` — change the `image:` value to:
   `docker://jonasbn/github-action-spellcheck:$VERSION`

2. Update `README.md` - change the referenced use in the various configuration examples to match the new version:
   `uses: rojopolis/spellcheck-github-actions@$VERSION`

3. Check `CHANGELOG.md` for an entry matching `$VERSION`. If none exists, warn and stop — ask the user to add a changelog entry before continuing.

4. Create a PR for the changes to `action.yml`, `README.md`, and the new changelog entry in `CHANGELOG.md`. Wait for the PR to be merged before proceeding.

5. On merge:
   ```bash
   perl scripts/build.pl $VERSION
   ```

6. Check the return value of the build script. If it fails, show the error and stop. The build script does the tagging and pushing to GitHub and Docker Hub.

   As of `1.0.0`, the script fails loudly (non-zero exit, clear message) instead of silently continuing: every Docker/git/gh command's exit status is checked, and it preflight-checks that Docker Hub credentials are configured (and Buildx is available) before building, and verifies each pushed tag is actually visible on Docker Hub afterward.

   The floating tag it moves is derived from `$VERSION`'s major (`v0` for `0.x.x`, `v1` for `1.x.x`, …) rather than hardcoded to `v0`, and each major's floating tag moves independently — so releasing a security backport to an older major after a newer major exists only moves that older major's tag. `latest` only moves if `$VERSION` is the highest version released across all majors, so a backport can never regress `latest`.

7. Confirm the tag was pushed
