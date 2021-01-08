# spellcheck-github-actions

A Github Action that spell checks Python, Markdown, and Text files.

This action uses [PySpelling][pyspelling] to check spelling in source files in the designated repository.

## Features

- Customizable configuration and spell checking using [PySpelling][pyspelling]
- Support for the following formats: Python, Markdown and plain text
- Per repository and format custom word list to avoid errors based on words not known to default dictionary, see: [PySpelling](https://facelessuser.github.io/pyspelling/configuration/) for more options
- Flexible repository layout integration via file name matching using [Wildcard Match][wcmatch]

## Configuration

1. First you have to add a configuration for the spelling checker
1. Create a file named: `.spellcheck.yml` or `.spellcheck.yaml`, do note if both files exist the prior will have precedence. Do note the recommendation is _hidden_ files since these configuration files are not first rate citizens of your repository
1. Paste the contents of the outlined example, which is a configuration for Markdown, useful for your README file

Do note that this action requires the contents of the repository, so it is recommended used with [the Checkout action][actioncheckout].

You have to define this part in your workflow, since it not a part of the action itself.

Example:

```yaml
name: Spellcheck Action
on: push

jobs:
  build:
    name: Spellcheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.5.0
      name: Spellcheck
```

Note the step: `- uses: actions/checkout@master`
This file must live in a the `.github/workflows/` directory.
For example, it could be `.github/workflows/action.yml`

## Spellcheck Configuration File

The file can be named:

1. `.spellcheck.yml`
1. `.spellcheck.yaml`
1. `spellcheck.yml`
1. `spellcheck.yaml` (the old default)

And is attempted read in that order, meaning first match is used, This means that you can use files prefixed with the `.` to have a less intrusive Spellcheck configuration in your repository.

```yaml
matrix:
- name: Markdown
  aspell:
    lang: en
  dictionary:
    encoding: utf-8
  pipeline:
  - pyspelling.filters.markdown:
  - pyspelling.filters.html:
    comments: false
    ignores:
    - code
    - pre
  sources:
  - '**/*.md'
  default_encoding: utf-8
```

The above configuration will check the spelling of your repository's `README.md` and other Markdown files against an English dictionary. If your Markdown is named differently, correct or add additional patterns under `sources`, Markdown is sometimes named `.mkdn`.

When and if the run locates spelling errors, you have two options:

1. Correct the spelling errors in the relevant files
1. Add the relevant words to a custom word list, to be ignored

If you do the latter, you have to add the following to the Spellcheck configuration, under `dictionary`:

```yaml
    wordlists:
    - .wordlist.txt
```

This supplies a custom list of words to supply the default dictionary for the specified language, in this case set to English `en` under `aspell`.

The complete configuration should resemble this:

```yaml
matrix:
- name: Markdown
  aspell:
    lang: en
  dictionary:
    wordlists:
    - .wordlist.txt
    encoding: utf-8
  pipeline:
  - pyspelling.filters.markdown:
  - pyspelling.filters.html:
    comments: false
    ignores:
    - code
    - pre
  sources:
  - '**/*.md'
  default_encoding: utf-8
```

Change the configuration to suit your repository and needs, please see the `examples/` directory for more example configurations.

## Checking For Bad Spelling

The GitHub Action helps you make sure _most_ spelling errors do not make it into your repository. You can however check your spelling prior to committing and pushing to your repository.

This simply uses the contents of our spelling toolchain:

```bash
$ pyspelling -c .spellcheck.yml
Misspelled words:

...

!!!Spelling check failed!!!
```

We can correct the error(s) pointed out by [PySpelling][pyspelling] as we go by adding _new_ words to our local file: `.wordlist.txt`

And at some point we get:

```bash
$ pyspelling -c .spellcheck.yml
Spelling check passed :)
```

Now we should be good to go.

Do note you could also use the `entrypoint.sh`, which is the script used in the Docker image.

```bash
± sh entrypoint.sh

Using pyspelling on repository files outlined in .spellcheck.yml
----------------------------------------------------------------
Spelling check passed :)
```

## Diagnostics

This is a list of common diagnostics, which can be emitted by the action and it's tools.

### Diagnostic text: `!!!Spelling check failed!!!`

This indicates that a spelling check has been completed, but spelling errors were located and should be corrected.

1. Either correct pinpointed spelling errors
1. Or add pinpointed words to custom dictionary

Please see the section: "Checking For Bad Spelling" above.

### Diagnostic text: `RuntimeError: None of the source targets from the configuration match any files:`

This diagnostic indicates that files outlines by the `source` wildcard pattern match did not match any files.

1. Either adjust the pattern
1. Or remove the configuration part since it does not match the repository contents

Please see the documentation for [Wildcard Match][wcmatch].

### Diagnostic text: `FileNotFoundError: [Errno 2] No such file or directory: '.wordlist.txt'`

This diagnostic indicates that a custom word list has been specified in the used configuration, `.spellcheck.yml`, but the file does not exist.

1. Create the empty file

```bash
$ touch .wordlist.txt
```

Please see the section: "Configuration" above.

### Diagnostic text: `ValueError: Unable to find or load pyspelling configuration from`

This diagnostic indicates that the configuration file pointed to with the `--config` (`-c`) parameter cannot be located.

1. Check that a file with the indicated name exists.

`ValueError: Unable to find or load pyspelling configuration from spellcheck.yaml`

Indicates: `spellcheck.yaml` so this file should exist in the repository.

If the file is available in the repository, please check that your workflow is configured correctly, with the following line, which enables [the action Checkout][actioncheckout].

`uses: actions/checkout@master`

If full context:

```yaml
name: Spellcheck Action
on: push

jobs:
  build:
    name: Spellcheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.5.0
      name: Spellcheck
```

This step adds an action, which checkout out the repository for inspection by linters and other actions like this one.

### Diagnostic text: `ERROR: *.md -- 'NoneType' object has no attribute 'end'`

This indicates issues with the Markdown and is reported by `Markdown` (See: [PyPi site](https://pypi.org/project/Markdown/)).

[PySpelling][pyspelling]  does however support extension of the standard Markdown parser and you can specify the use of extensions of these are support.

This action support the extensions included in: `pymdown-extensions` (See: [PyPi site](https://pypi.org/project/pymdown-extensions/))

And you can then put these to use in your configuration. The example below outlines the `superfences` extension.

```yaml
  - pyspelling.filters.markdown:
      markdown_extensions:
      - pymdownx.superfences:
```

Please see the repositorys `requirements.txt` for a list of all included Python modules and their exact versions.

## DockerHub

This action is based on a Docker image available on DockerHub.

This mean that if you developing your own spell checking action you can use this
image.

Alternatively you can build your own Docker image based on the `Dockerfile` in this repository.

- [DockerHub: jonasbn/github-action-spellcheck](https://hub.docker.com/r/jonasbn/github-action-spellcheck)

### A note on DockerHub

The images are build from the GitHub repository master branch.

The recommended use is to use the latest release with a version tag. See [the release history](https://github.com/rojopolis/spellcheck-github-actions/releases) for details.

Whereas the tag `latest` just reflect the latest build based on the master branch.

The master branch might contain changes not tagged as released yet and can be regarded as _unstable_ or _experimental_. Changes such as corrections to documentation etc. will not be tagged until separately as a general rule, unless the changes are significant, but the aim is to keep the documentation relevant and up to date.

## Development

The GitHub Action is based on a Docker implementation.

The `Dockerfile` contains the image building and the `entrypoint.sh`, which acts as `ENTRYPOINT` for the Docker image describes the execution part.

You can test the action locally by building the Docker image and running it against your project/repository.

First you have to build it.

Download or fork [the spellcheck action repository](https://github.com/rojopolis/spellcheck-github-actions).

Unpack or clone the source code and build the Docker image.

```bash
$ docker build -t github-action-spellcheck .
```

Run the newly build Docker image.

Do note the project/repository has to contain a configuration, please see the section on configuration above:

```bash
$ cd <your project/repository directory>
$ docker run -it  -v $PWD:/tmp github-action-spellcheck
```

## Author

The original author of this GitHub Action is Robert Jordan (@rojopolis)

## Acknowledgements

Here follows a list of contributors in alphabetical order:

- Albert Volkman, @albertvolkman
- Isaac Muse, @facelessuser
- Jonas Brømsø, @jonasbn
- José Eduardo Montenegro Cavalcanti de Oliveira, @edumco
- Michael Flaxman, @mflaxman
- Stephen Bates, @sbates130272

Do you want to be left out, or feel left out of this list or have a different representation of your name, please submit a pull request or raise an issue

## Copyright and License

This repository is licensed under the MIT license.

[pyspelling]: https://facelessuser.github.io/pyspelling/
[wcmatch]: https://facelessuser.github.io/wcmatch/glob/
[actioncheckout]: https://github.com/marketplace/actions/checkout
