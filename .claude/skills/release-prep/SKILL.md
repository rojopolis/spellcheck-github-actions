---
name: release-prep
description: Prepare a new release - bump action.yml image version, verify CHANGELOG entry, stage changes, and create a git tag
disable-model-invocation: true
---

Args: VERSION (e.g. 0.61.0)

Steps:

1. Update `action.yml` — change the `image:` value to:
   `docker://jonasbn/github-action-spellcheck:$VERSION`

2. Update `README.md` - change the referenced use in the various configuration examples to match the new version:
   `uses: rojopolis/spellcheck-github-actions@$VERSION`

3. Check `CHANGELOG.md` for an entry matching `$VERSION`. If none exists, warn and stop — ask the user to add a changelog entry before continuing.

4. Show `git diff action.yml` for review.

5. Show `git diff README.md` for review.

6. Ask the user to confirm before proceeding.

7. On confirmation:
   ```bash
   run perl scripts/build.pl $VERSION
   ```

8. Check the return value of the build script. If it fails, show the error and stop. The build script does the tagging and pushing to GitHub and Docker Hub.

9. Confirm the tag was pushed and remind the user that the Docker image CI workflow will trigger on the new tag.
