# Change Log for spellcheck-github-actions

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
  patch from @sbates130272, PR: #7. Please refer to the documentation for details

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
