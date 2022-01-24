# Change Log for spellcheck-github-actions

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

'The following dependencies have been updated:

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
