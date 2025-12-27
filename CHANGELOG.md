# Change Log for spellcheck-github-actions

- Docker image updated to Python 3.14.2 trixie slim [Release notes for Python 3.14.2](https://docs.python.org/release/3.14.2/whatsnew/changelog.html)
- Support for Portuguese (Portugal and Brazil) for both Hunspell and Aspell, requested by: @mdiazgoncalves via issue [#298](https://github.com/rojopolis/spellcheck-github-actions/issues/298)

## 0.55.0, 2025-11-27, maintenance release, update not required

- Via an issue [#293](https://github.com/rojopolis/spellcheck-github-actions/issues/293) from @shoverbj, an update to the core component **PySpelling** from version 2.12.0 to version `2.12.1` was made, this allows for use of large dictionaries with Aspell

## 0.54.0, 2025-11-05, feature release, update not required

- PySpelling the core component has been updated to version 2.12.0, which introduces support for maximum available cores. The feature is described in the [release notes for PySpelling 2.12.0](https://github.com/facelessuser/pyspelling/releases/tag/2.12.0). See the [documentation for PySpelling](https://facelessuser.github.io/pyspelling/configuration/).

- The flag was introduced with [release 2.10 of PySpelling](https://github.com/facelessuser/pyspelling/releases/tag/2.10.0), which was adopted in release 0.36.0 of this action.

## 0.53.0, 2025-10-25, maintenance release, update not required

- Docker image updated to Python 3.14.0 trixie slim [Release notes for Python 3.14.0](https://docs.python.org/release/3.14.0/whatsnew/changelog.html), this originated from the PR mentioned below, however updated to Trixie from Bookworm and as always the slim variant is used

- Bumped the requirement for cython to `3.0.11` or above, addressing a build issue with lxml, located when testing the PR : [#274](https://github.com/rojopolis/spellcheck-github-actions/pull/274) from @dependabot, the above update of Python

- In general the Docker build file had a few updates since the above changes required some tweaking of the Dockerfile
  - Order of installation of dependencies adjusted to ensure that lxml can build correctly
  - Installation of:
    - build-essential
    - pkg-config
    - libxml2-dev
    - libxslt1-dev
    - zlib1g-dev

## 0.52.0, 2025-09-10, feature release, update not required

- With version 2.11 of **PySpelling** a new command line option `--skip-dict-compile` is introduced to **PySpelling**  and is adopted by this action. This will skip the dictionary compiling step if the dictionary already exists. Changes to a custom dictionary will be ignored., see the [release notes for PySpelling](https://github.com/facelessuser/pyspelling/releases/tag/2.11). Do see the updated documentation for details.

  - The feature can be enabled by setting the input parameter `skip_dict_compile` to `true`, the default is `false`, meaning that the dictionary will be compiled on each run of the action.
  - This can save time if you have a large custom dictionary that does not change often.

- Docker image updated to Python 3.13.7 bookworm slim [Release notes for Python 3.13.7](https://docs.python.org/release/3.13.7/whatsnew/changelog.html)

## 0.51.0, 2025-06-20, maintenance release, update not required

- Docker image updated to Python 3.13.5 slim via PR [#249](https://github.com/rojopolis/spellcheck-github-actions/pull/249) from Dependabot. [Release notes for Python 3.13.5](https://docs.python.org/release/3.13.5/whatsnew/changelog.html)

## 0.50.0, 2025-06-16, maintenance release, update not required

- Docker image updated to Python 3.13.4 slim via PR [#246](https://github.com/rojopolis/spellcheck-github-actions/pull/246) from Dependabot. [Release notes for Python 3.13.4](https://docs.python.org/release/3.13.4/whatsnew/changelog.html)

## 0.49.0, 2025-05-22, feature release, update not required

- Support for Italian as requested by: Stefan Oderbolz (@metaodi) via issue [#241](https://github.com/rojopolis/spellcheck-github-actions/issues/241), the support is both for `aspell` and `hunspell`

- Docker image updated to Python 3.13.3 slim via PR [#238](https://github.com/rojopolis/spellcheck-github-actions/pull/238) from Dependabot. [Release notes for Python 3.13.3](https://docs.python.org/release/3.13.3/whatsnew/changelog.html)

- `pymdown-extensions`  have been updated to: `10.15.0` hopefully addressing the issue outlined in issue [#233](https://github.com/rojopolis/spellcheck-github-actions/issues/233) from: Micha Hobert (@Isengo1989). @facelessuser made the release of the dependency and I have included it in this release

## 0.48.0, 2025-04-01, feature release, update not required

- Support for `hunspell` via PR [#224](https://github.com/rojopolis/spellcheck-github-actions/pull/224) from @funkill

  These opens up for use of `hunspell` instead of the default: `aspell`. The following languages are supported:

  - English
  - German
  - Spanish
  - French
  - Russian
  - Ukranian

  And the `aspell` language support has been extended with:

  - Russian
  - Ukranian

  So the two spell checkers are aligned.

- The action now emits more information on what versions of tools it is using thanks to PR [#234](https://github.com/rojopolis/spellcheck-github-actions/pull/234) from @brooke-hamilton

  The tools are:

  - `aspell`
  - `hunspell`
  - `pyspelling`

- One step closer to full Docker image build automation via PR [#218](https://github.com/rojopolis/spellcheck-github-actions/pull/218) from @shyim.

  This means that the PR [#108](https://github.com/rojopolis/spellcheck-github-actions/pull/108) from @sxd was closed - the contribution from @sxd was highly appreciated since it helped to understand the problem area and the solution.

  PR [#218](https://github.com/rojopolis/spellcheck-github-actions/pull/218) addresses issue: [#193](https://github.com/rojopolis/spellcheck-github-actions/issues/193), which was a request for `arm64` support. Issue [#80](https://github.com/rojopolis/spellcheck-github-actions/issues/80) is still open and will not be closed until we have a fully automated build process for the Docker image.

## 0.47.0, 2025-02-11, maintenance release, update not required

- Docker image updated to Python 3.13.2 slim via PR [#228](https://github.com/rojopolis/spellcheck-github-actions/pull/228) from Dependabot. [Release notes for Python 3.13.2](https://docs.python.org/release/3.13.2/whatsnew/changelog.html)

## 0.46.0, 2025-01-07, maintenance release, update not required

- Docker image updated to Python 3.13.1 slim via PR [#225](https://github.com/rojopolis/spellcheck-github-actions/pull/225) from Dependabot. [Release notes for Python 3.13.1](https://docs.python.org/release/3.13.1/whatsnew/changelog.html)

## 0.45.0, 2024-11-05, maintenance release, update not required

- Docker base image updated from `python:3.13.0-slim-bullseye` to `python:3.13.0-slim-bookworm`. Which should
  give us some time in to live, end of life take into consideration:

  - https://endoflife.date/debian

## 0.44.0, 2024-10-25, maintenance release, update not required

- Docker image updated to Python 3.13.0 slim via PR [#217](https://github.com/rojopolis/spellcheck-github-actions/pull/217) from Dependabot. [Release notes for Python 3.13.0](https://docs.python.org/release/3.13.0/whatsnew/changelog.html)

- Since lxml was not building I bumped to the latest release 5.3.0. In in relation to that, so I while I was at it I went through the dependencies and updated the ones possible using a PySpelling build as the baseline. The following dependencies were updated:

- beautifulsoup4 bumped from version 4.12.2 to 4.12.3, see [release notes](https://git.launchpad.net/beautifulsoup/tree/CHANGELOG)
- lxml bumped from version 4.9.3 to 5.3.0, see [release notes](https://github.com/lxml/lxml/blob/master/CHANGES.txt)
- Markdown bumped from version 3.4.4 to 3.7, see [release notes](https://python-markdown.github.io/changelog/#37-2024-08-16)
- pymdown-extensions bumped from version 10.4 to 10.11.2, see [release notes](https://github.com/facelessuser/pymdown-extensions/releases/tag/10.11.2)
- PyYAML bumped from version 6.0.1 to 6.0.2, see [release notes](https://github.com/yaml/pyyaml/blob/main/CHANGES)
- soupsieve bumped from version 2.5 to 2.6, see [release notes](https://github.com/facelessuser/soupsieve/releases/tag/2.6)

## 0.43.1, 2024-10-17, bug fix release, update recommended

- This is an attempt at addressing the conflict between using the PySpelling `--source` parameter and the `sources` parameter in the PySpelling configuration file introduced by this action. With the recommendation of using the GitHub Action: [tj-actions/changed-files](https://github.com/marketplace/actions/changed-files), the use of the `--source` flag was adopted, but this bypasses the filtering mechanism, which can be enabled in the configuration file. The update recommendation is due to the fact that you might experience unwanted behaviour if your `sources` contain negated file patterns. The patch enables application of the configured filter to the source parameters, so the action can be used with the `--source` parameter and the `sources` configuration parameter in combination.

  - Issue [#213](https://github.com/rojopolis/spellcheck-github-actions/issues/213)

## 0.43.0, 2024-10-08, maintenance release, update not required

- Docker image updated to Python 3.12.7 slim via PR [#215](https://github.com/rojopolis/spellcheck-github-actions/pull/215) from Dependabot. [Release notes for Python 3.12.7](https://docs.python.org/release/3.12.7/whatsnew/changelog.html)

## 0.42.0, 2024-09-22, maintenance release, update not required

- Docker image updated to Python 3.12.6 slim via PR [#212](https://github.com/rojopolis/spellcheck-github-actions/pull/212) from Dependabot. [Release notes for Python 3.12.6](https://docs.python.org/release/3.12.6/whatsnew/changelog.html)

## 0.41.0, 2024-08-12, maintenance release, update not required

- Docker image updated to Python 3.12.5 slim via PR [#210](https://github.com/rojopolis/spellcheck-github-actions/pull/210) from Dependabot. [Release notes for Python 3.12.5](https://docs.python.org/release/3.12.5/whatsnew/changelog.html)

## 0.40.0, 2024-07-18, maintenance release, update recommended

- Minor error in the previous release, re-releasing as `0.40.0` see changes from `0.39.0` below

## 0.39.0, 2024-07-17, maintenance release, update recommended

- PR from @snyk-bot [#204](https://github.com/rojopolis/spellcheck-github-actions/pull/204) this updates the indirect Python dependency `zipp` from version `3.15.0` to `3.19.1`
  The dependency has a security flaw, please see below references.

  Do note `zipp` is not a direct dependency, but it is a dependency of `importlib-metadata`, which is a dependency of `pyspelling`, which is the core component of this action.

  By indicating is as a direct dependency of version 3.19.1, we can ensure that the action is not vulnerable, even though the vulnerability might not directly exploitable in the context of this action.

  References:
  - [Snyk description of issue](https://security.snyk.io/package/pip/zipp/3.15.0)
  - [GitHub Security Advisory](https://github.com/advisories/GHSA-jfmj-5v4g-7637)
  - [CVE-2024-5569](https://github.com/advisories/GHSA-jfmj-5v4g-7637)
  - [Release notes for zipp 3.19.1](https://pypi.org/project/zipp/3.19.1/)

## 0.38.0, 2024-06-13, maintenance release, update not required

- Docker image updated to Python 3.12.4 slim via PR [#202](https://github.com/rojopolis/spellcheck-github-actions/pull/202) from Dependabot. [Release notes for Python 3.12.4](https://docs.python.org/release/3.12.4/whatsnew/changelog.html)

## 0.37.0, 2024-06-01, maintenance release, update not required

- Docker image updated to Python 3.12.3 slim via PR [#199](https://github.com/rojopolis/spellcheck-github-actions/pull/199) from Dependabot. [Release notes for Python 3.12.3](https://docs.python.org/release/3.12.3/whatsnew/changelog.html)

- Docker image updated to Python 3.12.2 slim via PR [#197](https://github.com/rojopolis/spellcheck-github-actions/pull/197) from Dependabot. [Release notes for Python 3.12.2](https://docs.python.org/release/3.12.2/whatsnew/changelog.html)

## 0.36.0, 2024-02-06, feature release, update not required

- With version 2.10 of **PySpelling** the action now supports the configuration of running jobs in parallel, see the [documentation for PySpelling](https://facelessuser.github.io/pyspelling/configuration/)

- Docker image updated to Python 3.12.1 slim via PR [#191](https://github.com/rojopolis/spellcheck-github-actions/pull/191) from Dependabot. [Release notes for Python 3.12.1](https://docs.python.org/release/3.12.1/whatsnew/changelog.html)

## 0.35.0, 2023-11-16, maintenance release, update not required

- Docker image updated to Python 3.12.0 slim via PR [#177](https://github.com/rojopolis/spellcheck-github-actions/pull/177) from Snyk. [Release notes for Python 3.12.0](https://docs.python.org/release/3.12.0/whatsnew/changelog.html)

Bumping to Python 3.12.0 slim, introduced a number of dependency updates, not all were required, but I have decided to update quite a few, since the Docker image is rebuilt anyway.

- backrefs bumped from version 5.0.1 to 5.6.0, see [release notes](https://github.com/facelessuser/backrefs/releases/tag/5.6)
- beautifulsoup4 bumped from version 4.9.3 to 4.12.2, see [release notes](https://git.launchpad.net/beautifulsoup/tree/CHANGELOG)
- lxml bumped from version 4.9.2 to 4.9.3, see [release notes](https://github.com/lxml/lxml/blob/master/CHANGES.txt)
- Markdown bumped from version 3.3.4 to 3.4.4, see [release notes](https://python-markdown.github.io/changelog/#344-2023-07-25)
- pymdown-extensions bumped from version 10.0.1 to 10.4, see [release notes](https://github.com/facelessuser/pymdown-extensions/releases/tag/10.4)
- PyYAML bumped from version 5.4.1 to 6.0.1, see [release notes](https://github.com/yaml/pyyaml/blob/main/CHANGES)
- soupsieve bumped from version 2.2.1 to 2.5, see [release notes](https://github.com/facelessuser/soupsieve/releases/tag/2.5)

## 0.34.0, 2023-09-29, maintenance release, update not required

- Bumped the core component PySpelling to version 2.9, together with wcmatch, bumped to version 2.5, all via PR [#174](https://github.com/rojopolis/spellcheck-github-actions/pull/170) bu @jonasbn

- Docker image updated to Python 3.11.5 slim via PR [#170](https://github.com/rojopolis/spellcheck-github-actions/pull/170) from Snyk. [Release notes for Python 3.11.5](https://docs.python.org/release/3.11.5/whatsnew/changelog.html)

- Added constraint for `requirements.txt` since one of the dependencies does not support Cython version 3.

I found two guides to fixing the problem:

- ["Getting requirements to build wheel did not run successfully for sap aicore"](https://answers.sap.com/questions/13931156/getting-requirements-to-build-wheel-did-not-run-su.html)
- ["Getting requirements to build wheel did not run successfully exit code: 1"](https://discuss.python.org/t/getting-requirements-to-build-wheel-did-not-run-successfully-exit-code-1/30365)

They state somewhat the same and I have applied a fix via PR [#172](https://github.com/rojopolis/spellcheck-github-actions/pull/172) now the Docker image can build again

## 0.33.1, 2023-07-13, bug fix release, update not required

- An update is recommended if you are using the `output_file` parameter, since the output file handling was shielding the propagation of the status of the actual spellcheck.

  The issue was observed in [#166](https://github.com/rojopolis/spellcheck-github-actions/issues/166) reported by @nlhomme, where the action was reporting success, even though the spellcheck was failing.

  The bug information was lifted into a new issue [#167](https://github.com/rojopolis/spellcheck-github-actions/issues/167) and was addressed in PR [#168](https://github.com/rojopolis/spellcheck-github-actions/pull/168) by @jonasbn

## 0.33.0, 2023-06-16, maintenance release, update not required

- Docker image updated to Python 3.11.4 slim via PR [#164](https://github.com/rojopolis/spellcheck-github-actions/pull/164) from Snyk. [Release notes for Python 3.11.4](https://docs.python.org/release/3.11.4/whatsnew/changelog.html)

## 0.32.0, 2023-05-18, security patch release, update recommended

- @dependabot raised [an alert](https://github.com/rojopolis/spellcheck-github-actions/security/dependabot/3) for the used dependency: [pymdown-extensions](https://github.com/facelessuser/pymdown-extensions). The vulnerability is labelled as [CVE-2023-32309](https://nvd.nist.gov/vuln/detail/CVE-2023-32309). The issue has been present in [pymdown-extensions](https://github.com/facelessuser/pymdown-extensions) since version [1.5.0](https://github.com/facelessuser/pymdown-extensions/releases/tag/1.5.0) and is patched in version [10.0](https://github.com/facelessuser/pymdown-extensions/releases/tag/10.0).

- Snyk has provided a patch via PR [#158](https://github.com/rojopolis/spellcheck-github-actions/pull/158), which has been tested and no regressions has been observed, even with a version leap for [pymdown-extensions](https://github.com/facelessuser/pymdown-extensions). from version [8.2](https://github.com/facelessuser/pymdown-extensions/releases/tag/8.2) to [10.0](https://github.com/facelessuser/pymdown-extensions/releases/tag/10.0). The GitHub Action has been updated to use the patched version, even though there are no direct use of the vulnerable code in the action, but we do not want to be the source of a vulnerability.

- [pymdown-extensions](https://github.com/facelessuser/pymdown-extensions) was increased to version [10.0.1](https://github.com/facelessuser/pymdown-extensions/releases/tag/10.0.1), since a bug fix was released to follow up on the security patch.

## 0.31.0, 2023-05-16, maintenance release, update not required

- Docker image updated to Python 3.11.3 slim via PR [#152](https://github.com/rojopolis/spellcheck-github-actions/pull/152) from @dependabot. [Release notes for Python 3.11.3](https://docs.python.org/release/3.11.3/whatsnew/changelog.html)

## 0.30.0, 2023-02-20, maintenance release, update not required

- PySpelling updated from version 2.8.1 to 2.8.2, including several fixes
  - FIX: Ensure that Aspell actually uses the encoding passed to it for dictionaries.
  - FIX: Use a disallow list for problematic or unsupported arguments to the underlying spell checker instead of using a more restrictive allow list.
  - FIX: Fix logic bug in JavaScript filter.
- Lifted from  the [release notes for PySpelling](https://github.com/facelessuser/pyspelling/releases/tag/2.8.2)

- Docker image updated to Python 3.11.2 slim via PR [#142](https://github.com/rojopolis/spellcheck-github-actions/pull/142) from @dependabot. [Release notes for Python 3.11.2](https://docs.python.org/release/3.11.2/whatsnew/changelog.html)

## 0.29.0, 2022-12-29, maintenance release, update not required

- Docker image updated to Python 3.11.1 slim via PR [#139](https://github.com/rojopolis/spellcheck-github-actions/pull/139) from @dependabot. [Release notes for Python 3.11.1](https://docs.python.org/release/3.11.1/whatsnew/changelog.html)

- [lxml](https://pypi.org/project/lxml/) bumped to version 4.9.1 from 4.9.1 to get the build to work, without jumping through too many hoops. We prefer relying on wheel instead of building from source, since `lxml` can become quite a time sink

## 0.28.0, 2022-11-16, maintenance release, update not required

- Docker image updated to Python 3.10.8 slim via PR [#129](https://github.com/rojopolis/spellcheck-github-actions/pull/129) from @snyk-bot. [Release notes for Python 3.10.8](https://docs.python.org/release/3.10.8/whatsnew/changelog.html)

## 0.27.0, 2022-09-09, feature release, update not required

- Support for default PySpelling configuration files via PR [#116](https://github.com/rojopolis/spellcheck-github-actions/pull/116) from @proffalken

- Docker image updated to Python 3.10.6 slim via PR [#117](https://github.com/rojopolis/spellcheck-github-actions/pull/117) from @dependabot. [Release notes for Python 3.10.6](https://docs.python.org/release/3.10.6/whatsnew/changelog.html#python-3-10-6-final)

## 0.26.0, 2022-08-04, maintenance release, update recommended

- The core component PySpelling has been updated from version 2.7.3 to version 2.8.1, see the [release history for PySpelling](https://github.com/facelessuser/pyspelling/releases)

## 0.25.0, 2022-07-08, maintenance release, update recommended

- `lxml` requirement bumped from version 4.6.5 to 4.9.1 addressing a security issue [SNYK-PYTHON-LXML-2940874](https://security.snyk.io/vuln/SNYK-PYTHON-LXML-2940874) / [CVE-2022-2309](https://www.cve.org/CVERecord?id=CVE-2022-2309) / [CWE-476](https://cwe.mitre.org/data/definitions/476.html) via PR [#104](https://github.com/rojopolis/spellcheck-github-actions/pull/104) from @snyk-bot

- Docker image updated to Python 3.10.5 slim from 3.10.4 slim via PR [#102](https://github.com/rojopolis/spellcheck-github-actions/pull/102) from @dependabot. [Release notes for Python 3.10.5](https://docs.python.org/release/3.10.5/whatsnew/changelog.html#python-3-10-5-final)

## 0.24.0, 2022-05-17, feature release, update not required

- @riccardoporreca created issue [#68](https://github.com/rojopolis/spellcheck-github-actions/issues/68) requested the ability to create an output artifact.

  With release 0.24.0 this is now available.

  The action configuration has to have the `output_file` parameter specified, which is a new optional parameter.

  ```yaml
  name: Spellcheck Action

  on:
    workflow_dispatch:
    push:

  jobs:
    build:
      name: Spellcheck
      runs-on: ubuntu-latest
      steps:

      - uses: actions/checkout@v3

      - uses: rojopolis/spellcheck-github-actions@0.24.0
        name: Spellcheck (no output file)
        with:
          source_files: README.md CHANGELOG.md

      - uses: rojopolis/spellcheck-github-actions@0.24.0
        name: Spellcheck (with output file)
        with:
          source_files: README.md CHANGELOG.md
          task_name: Markdown
          output_file: spellcheck-output.txt

      - uses: actions/upload-artifact@v3
        name: Archive spellcheck output output
        with:
          name: Spellcheck artifact
          path: spellcheck-output.txt
  ```

  This introduces the use of the `upload-artifact@v3` action.

  The generated artifact can be downloaded via GitHub UI/API, please consult the documentation for details and pointers.

  Thanks to @riccardoporreca for his suggestion.

## 0.23.2, 2022-05-05, bug fix release, update not required

- Minor issue in release 0.23.1, the action was not adjusted to the latest release

## 0.23.1, 2022-05-05, bug fix release, update not required

- Addressing issue [#84](https://github.com/rojopolis/spellcheck-github-actions/issues/84) via PR [#90](https://github.com/rojopolis/spellcheck-github-actions/pull/90) from @jonasbn. With the introduction of use of optional quotes, do note the limitations outlined in the [documentation](https://github.com/rojopolis/spellcheck-github-actions#specifying-sources-files-to-check) - thanks to @xsaero00 for the bug report

## 0.23.0, 2022-04-09, feature release, update not required

- Support for the French language. Support requested by @gcattan via issue [#87](https://github.com/rojopolis/spellcheck-github-actions/issue/87)

- Docker image updated to Python 3.10.4 slim via PR [#86](https://github.com/rojopolis/spellcheck-github-actions/pull/86) from @dependabot. [Release notes for Python 3.10.4](https://docs.python.org/release/3.10.4/whatsnew/changelog.html#python-3-10-4-final)

- Docker image updated to Python 3.10.3 slim via PR [#85](https://github.com/rojopolis/spellcheck-github-actions/pull/85) from @dependabot. [Release notes for Python 3.10.3](https://docs.python.org/release/3.10.3/whatsnew/changelog.html#python-3-10-3-final)

## 0.22.1, 2022-02-23, bug fix release, update recommended

- Testing the new Spanish support feature more thoroughly, demonstrated that the Docker build process was broken and only English worked

  - I addressed issue [#57](https://github.com/rojopolis/spellcheck-github-actions/issues/57), which demonstrated an issue with the Docker build, the issue is no longer relevant with the simplification of the Docker build via PR: [#82](https://github.com/rojopolis/spellcheck-github-actions/pull/82) by me (@jonasbn)

## 0.22.0, 2022-02-21, feature release, update not required

- Support for the Spanish language. Support requested and implemented by @electrocucaracha via PR [#81](https://github.com/rojopolis/spellcheck-github-actions/pull/81)

## 0.21.1, 2022-01-25, bug fix release, update required

- Release 0.21.0 was build and uploaded from the wrong architecture. This release addressed this issue ([#79](https://github.com/rojopolis/spellcheck-github-actions/issues/79)), thanks @chrispat for reporting

## 0.21.0, 2022-01-24, maintenance release, update not required

- Docker image updated to Python 3.10.2 slim via PR [#78](https://github.com/rojopolis/spellcheck-github-actions/pull/78) from @dependabot

## 0.20.0, 2021-12-21, bug fix release, update recommended

- Made the version specified in the `action.yml` follow the version indicated in the repository. Apparently we where pointing to `latest`, which is good _when_ and _if_ we are backwards compatible and yes we are still in _alpha_ expressed semantically by the version numbers starting with `0` as in `0.20.0`. This would however allow for us to release breaking changes, without breaking a lot of workflows, which would fetch the _latest_ Docker image, which can be either _unstable_ or a major release

## 0.19.0, 2021-12-18, security release, update recommended

- Requirement [lxml](https://pypi.org/project/lxml/) updated from 4.6.3 to 4.6.5 via PR [#71](https://github.com/rojopolis/spellcheck-github-actions/pull/71) from @snyk-bot. This addresses a security, cross-site scripting vulnerability (XSS) in the [lxml](https://pypi.org/project/lxml/) library, see [SNYK-PYTHON-LXML-2316995](https://security.snyk.io/vuln/SNYK-PYTHON-LXML-2316995)

From the [release notes for lxml 4.6.5](https://pypi.org/project/lxml/4.6.5/):

> A vulnerability (GHSL-2021-1038) in the HTML cleaner allowed sneaking script content through SVG images.
> A vulnerability (GHSL-2021-1037) in the HTML cleaner allowed sneaking script content through CSS imports and other crafted constructs.

- Docker image updated to Python 3.10.1 slim via PR [#70](https://github.com/rojopolis/spellcheck-github-actions/pull/70) from @dependabot

## 0.18.0, 2021-10-31 feature release, update not required

- This release introduces an enhancement or new feature if your will, implemented by @riccardoporreca via PR [#67](https://github.com/rojopolis/spellcheck-github-actions/pull/67). The enhancement takes advantage of the ability to [make annotations on actions](https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions#setting-an-error-message), so you can from the action overview see an annotation indicating the error by the emitted error message from the action

## 0.17.0, 2021-10-14 maintenance release, update not required

- Docker image updated to Python 3.9.7 slim via PR [#62](https://github.com/rojopolis/spellcheck-github-actions/pull/62) and again to Python 3.10.0 slim via PR [#64](https://github.com/rojopolis/spellcheck-github-actions/pull/64) both from dependabot

## 0.16.0 2021-08-15 bug fix release, update recommended

Experienced an issue with the new multi-stage Docker build, where `aspell` _disappears_.

This release implements a _hack_ to make use that it is present, by reinstalling it :-/

REF: PR [#56](https://github.com/rojopolis/spellcheck-github-actions/pull/56) addressing issue [#55](https://github.com/rojopolis/spellcheck-github-actions/issues/55)

The issue in the Docker build is patched, but is still present, see issue [#57](https://github.com/rojopolis/spellcheck-github-actions/issues/57)

## 0.15.0 2021-08-15 maintenance release, update not required

WARNING! This release is not working, please use release 0.16.0

Issue [#53](https://github.com/rojopolis/spellcheck-github-actions/issues/53) describes an issue with ignoring Markdown regions with code fences. This was an issue in `pyspelling`, which is the core component in this action. Luckily @facelessuser, the maintainer of `pyspelling` was to [fix it](https://github.com/facelessuser/pyspelling/pull/144). So the requirement for `pyspelling` was bumped from 2.6.1 to 2.7.3

Thanks to @supernovae and @facelessuser

This however demonstrated that several of the dependencies was not up to date.

The following dependencies have been updated:

- [backrefs](https://pypi.org/project/backrefs/) updated from 4.5 to 5.0.1
- [bracex](https://pypi.org/project/bracex/) updated from 2.0.1 to 2.1.1
- [lxml](https://pypi.org/project/lxml/) updated from 4.6.0 to 4.6.3
- [Markdown](https://pypi.org/project/Markdown/) updated from 3.3.1 to 3.3.4
- [pymdown-extensions](https://pypi.org/project/pymdown-extensions/) updated from 8.1 to 8.2
- [pyspelling](https://pypi.org/project/pyspelling/) updated from 2.6.1 to 2.7.3
- [PyYAML](https://pypi.org/project/PyYAML/) updated from 5.3.1 to 5.4.1
- [six](https://pypi.org/project/six/) updated from 1.15.0 to 1.16.0
- [soupsieve](https://pypi.org/project/soupsieve/) updated from 2.0.1 to 2.2.1
- [wcmatch](https://pypi.org/project/wcmatch/) updated from 7.1 to 8.2

Additionally some work has been done in regard to the Docker build, so it is possible to specify new languages, using multi-stage build, see PR [#39](https://github.com/rojopolis/spellcheck-github-actions/pull/39) addressing issue: [#13](https://github.com/rojopolis/spellcheck-github-actions/issues/13)

Please see [the Wiki](https://github.com/rojopolis/spellcheck-github-actions/wiki/Development) for details.

Thanks to @aSemy and @edumco

- Thanks to @PeterPetrik for correction to command line example in README

- Docker image updated to Python 3.9.6 slim via PR [#51](https://github.com/rojopolis/spellcheck-github-actions/pull/51) from @dependabot

## 0.14.0 2021-05-13 maintenance release, update not required

- Docker image updated to Python 3.9.5 slim via PR [#48](https://github.com/rojopolis/spellcheck-github-actions/pull/48) from @dependabot

## 0.13.0 2021-04-14 maintenance release, update not required

- Docker image updated to Python 3.9.4 slim via PR [#41](https://github.com/rojopolis/spellcheck-github-actions/pull/41) from @dependabot

## 0.12.0 2021-02-22 maintenance release, update not required

- Docker image updated to Python 3.9.2 slim via PR [#38](https://github.com/rojopolis/spellcheck-github-actions/pull/38) from @dependabot

## 0.11.0 2021-02-19 feature release, update not required

- Added support for German spelling: `lang: de`, including: Swiss and Austrian dictionaries addressing issue [#35](https://github.com/rojopolis/spellcheck-github-actions/issues/35) via PR [#36](https://github.com/rojopolis/spellcheck-github-actions/pull/36). This is experimental and will need further investigation. Aspell support 53 different dictionaries and supporting them all increases the Docker image size significantly so dynamic loading of dictionaries has to be investigated further, without increasing build time to a point where a pre-built Docker image is not longer feasible

## 0.10.0 2021-02-06 feature release, update not required

- Added capability to specify a set of files in the action, bypassing the filename pattern specified in the configuration. Implementation from PR [#34](https://github.com/rojopolis/spellcheck-github-actions/pull/34) from Matt Calvert, @miff2000

## 0.9.1 2021-01-12 bug fix release, update not required

- Minor correction to the documentation, a significant change did not make it into 0.9.0, , PR [#32](https://github.com/rojopolis/spellcheck-github-actions/pull/32) from Pavel Skipenes, @pavelskipenes

## 0.9.0 2021-01-11 feature release, update not required

- Added new ability specify an alternative path to a configuration file, PR [#31](https://github.com/rojopolis/spellcheck-github-actions/pull/31) from Pavel Skipenes, @pavelskipenes

## 0.8.0 2021-01-08 feature release, update not required

- Added support for extensions for Python's Markdown, namely the `pymdown-extensions` introducing the `superfences` extension, which can be used to address certain issue, which cannot be handled by handling of codefences by the Python Markdown implementation out of the box

## 0.7.0 2020-12-14 maintenance release, update not required

- Docker image updated to Python 3.9.1 slim via PR [#27](https://github.com/rojopolis/spellcheck-github-actions/pull/27) from @dependabot

## 0.6.0 2020-10-18 feature release, update recommended

- Docker image updated to Python 3.9.0 slim

- Python requirement `lxml` updated to version 4.6.0, with wheel supporting Python 3.9.0

- Requirement `pyspelling` updated to version 2.6.1 from 2.6.0

- Python requirement `backrefs` updated to version 4.5

- Python requirement `beautifulsoup4` updated to version 4.9.3

- Python requirement `bracex` updated to version 2.0.1

- Python requirement `html5lib` updated to version 1.1

- Python requirement `Markdown` updated to version 3.3.1

- Python requirement `wcmatch` updated to version 7.1

Contribution to documentation by Michael Flaxman, @mflaxman

## 0.5.0 2020-06-05 feature release, update recommended

- The action now uses a DockerHub served image, which mean that the Docker image does not have to be built at every invocation

- The documentation has been updated and the use of the `wordlist.txt` is no longer default. You have to introduce it yourself into your configuration, meaning that everything still works as expected for existing configurations

- A minor bug introduced in 0.4.0 in the handling of the `wordlist.txt` was addressed

## 0.4.0 2020-05-28 feature release, update recommended

- Introduced support for: `yml` extension in addition to `yaml` for YAML configuration files. Please refer to the documentation for details

- Introduced support for hidden configuration files, so prefixing the spellcheck configuration file to make it less intrusive in your repository is now supported
  patch from @sbates130272, PR: [#7](https://github.com/rojopolis/spellcheck-github-actions/pull/7). Please refer to the documentation for details

- The default configuration has been limited to Markdown, please see additional examples in the `examples/` directory

- Updates to documentation, still work in progress

- Improved support to local development using Docker

- Release 0.3.0 (below) never made it to [the GitHub Marketplace](https://github.community/t/who-can-publish-an-action-to-the-marketplace/115602/3), this might be due to a missing `action.yml`

## 0.3.0 2020-02-14 bug fix release, update recommended

- Addressing issue with `wordlist.txt` file handling

- This release never made it to the GitHub Marketplace, this might be due to changes in GitHub requirements, please see following release 0.4.0

## 0.2.0 2019-05-24 feature release, update recommended

- Introducing support for custom configurations and dictionaries

## 0.1.0 2019-05-23 feature release

- Initial release by @rojopolis
