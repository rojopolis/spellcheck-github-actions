---
name: docker-test
description: Build the Docker image as :local and run the full Bats test suite
disable-model-invocation: true
---

Run the full test cycle for the spellcheck action:

1. Build the local Docker image:
   ```bash
   docker build -t jonasbn/github-action-spellcheck:local .
   ```

2. Run all Bats tests against the local image:
   ```bash
   bats test/test.bats
   ```

3. Report which tests passed or failed. If the Docker build failed, show the build error before proceeding.

To run a single test by name, use:
```bash
bats --filter "<test name>" test/test.bats
```
