# Change Log for spellcheck-github-actions

## 0.34.0, 2023-09-XX, maintenance release, update not required

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
