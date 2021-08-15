# Change Log for spellcheck-github-actions

## 0.15.0 2021-08-13 maintenance release, update not required

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

## 0.14.0 2021-05-13 maintenance release, update not required

- Docker image updated to Python 3.9.5 slim via PR [#48](https://github.com/rojopolis/spellcheck-github-actions/pull/48) from dependabot

## 0.13.0 2021-04-14 maintenance release, update not required

- Docker image updated to Python 3.9.4 slim via PR [#41](https://github.com/rojopolis/spellcheck-github-actions/pull/41) from dependabot

## 0.12.0 2021-02-22 maintenance release, update not required

- Docker image updated to Python 3.9.2 slim via PR [#38](https://github.com/rojopolis/spellcheck-github-actions/pull/38) from dependabot

## 0.11.0 2021-02-19 feature release, update not required

- Added support for German spelling: `lang: de`, including: Swiss and Austrian dictionaries addressing issue [#35](https://github.com/rojopolis/spellcheck-github-actions/issues/35) via PR [#36](https://github.com/rojopolis/spellcheck-github-actions/pull/36). This is experimental and will need further investigation. Aspell support 53 different dictionaries and supporting them all increases the Docker image size significantly so dynamic loading of dictionaries has to be investigated further, without increasing build time to a point where a pre-built Docker image is not longer feasible

## 0.10.0 2021-02-06 feature release, update not required

- Added capability to specify a set of files in the action, bypassing the filename pattern specified in the configuration. Implementation from PR [#34](https://github.com/rojopolis/spellcheck-github-actions/pull/34) from Matt Calvert

## 0.9.1 2021-01-12 bug fix release, update not required

- Minor correction to the documentation, a significant change did not make it into 0.9.0, , PR [#32](https://github.com/rojopolis/spellcheck-github-actions/pull/32) from Pavel Skipenes

## 0.9.0 2021-01-11 feature release, update not required

- Added new ability specify an alternative path to a configuration file, PR [#31](https://github.com/rojopolis/spellcheck-github-actions/pull/31) from Pavel Skipenes

## 0.8.0 2021-01-08 feature release, update not required

- Added support for extensions for Python's Markdown, namely the `pymdown-extensions` introducing the `superfences` extension, which can be used to address certain issue, which cannot be handled by handling of codefences by the Python Markdown implementation out of the box

## 0.7.0 2020-12-14 maintenance release, update not required

- Docker image updated to Python 3.9.1 slim via PR [#27](https://github.com/rojopolis/spellcheck-github-actions/pull/27) from dependabot

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

- Release 0.3.0 (below) never made it to [the GitHub Marketplace](https://github.community/t/who-can-publish-an-action-to-the-marketplace/115602/3), this might be due to a missing `action.yml` please see:

## 0.3.0 2020-02-14 bug fix release, update recommended

- Addressing issue with `wordlist.txt` file handling

- This release never made it to the GitHub Marketplace, this might be due to changes in GitHub requirements, please see following release 0.4.0

## 0.2.0 2019-05-24 feature release, update recommended

- Introducing support for custom configurations and dictionaries

## 0.1.0 2019-05-23 feature release

- Initial release by @rojopolis
