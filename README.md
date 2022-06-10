
# spellcheck-github-actions

![Markdownlint Action][GHAMKDBADGE]
![Spellcheck Action][GHASPLLBADGE]

A Github Action that spell checks Python, Markdown, and Text files.

This action uses [PySpelling][pyspelling] to check spelling in source files in the designated repository.

## Features

- Customizable configuration and spell checking using [PySpelling][pyspelling]
- Support for the following formats: Python, Markdown and plain text
- Support for `aspell`, Do see the section on Language Support for details
- Support for the following languages:
  - English
  - French
  - German
  - Spanish
  - Do see the section on Language Support for details
- Per repository and format custom word list to avoid errors based on words not known to default dictionary, see: [PySpelling](https://facelessuser.github.io/pyspelling/configuration/) for more options
- Flexible repository layout integration via file name matching using [Wildcard Match][wcmatch]
- Support for Python's Markdown extensions, namely the `pymdown-extensions` via [PySpelling][pyspelling]

## Configuration

1. First you have to add a configuration for the spelling checker
1. Create a file named: `.spellcheck.yml` or `.spellcheck.yaml`, do note if both files exist the prior will have precedence. Do note the recommendation is _hidden_ files since these configuration files are not first rate citizens of your repository. You can also provide your own configuration file. Check out spellcheck configuration section down below.
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
    # The checkout step
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.24.0
      name: Spellcheck
```

This configuration file must be created in a the `.github/workflows/` directory.

For example, it could be named `.github/workflows/spelling_action.yml` for easy identification, if other actions are present.

## Specifying Sources Files To Check

By default, this action will use the `sources:` list under each task in your config file to identify which files to scan. You can override this behaviour by setting `source_files` to the list of files or file patterns you want scanning.

When this option is used, you must also specify the `task_name` to override the `sources:` list for.

Do note that file paths containing spaces need to be quoted using either `'` (single quotes) or `"` (double quotes). The quoting has to be uniform and the two quoting styles can not be intermixed.

### Examples

Parts are lifted from issue [#84](https://github.com/rojopolis/spellcheck-github-actions/issues/84)

#### No spaces, quotes not required

```yaml
source_files: README.md CHANGELOG.md notes/Notes.md
```

#### No spaces, quotes not required, double quotes used for complete parameter

```yaml
source_files: "README.md CHANGELOG.md notes/Notes.md"
```

This might actually work, but it is not recommended and might it might break, instead using proper quoting.

#### No spaces, quotes not required, double quotes used for single parameters

```yaml
source_files: "README.md" "CHANGELOG.md" "notes/Notes.md"
```

This would also work using single quotes

#### Spaces, quotes required, single quotes used

```yaml
source_files: 'Managed Services/Security Monitor/README.md' 'Terraform/Development Guide/README.md'
```

#### Spaces, quotes required, double quotes used

```yaml
source_files: "Managed Services/Security Monitor/README.md" "Terraform/Development Guide/README.md"
```

#### Spaces, quotes required, intermixed quotes, will not work

```yaml
source_files: README.md CHANGELOG.md notes/Notes.md
```

## Specify a Specific Task To Run

By default, all tasks in your config file will be run. By setting `task_name` you can override this and run only the task you require.

A configuration for designated source files could look as follows.

Example:

```yaml
name: Spellcheck Action
on: push

jobs:
  build:
    name: Spellcheck
    runs-on: ubuntu-latest
    steps:
    # The checkout step
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.24.0
      name: Spellcheck
      with:
        source_files: README.md CHANGELOG.md notes/Notes.md
        task_name: Markdown
```

## Specify a PySpelling Output Artifact

In order to make it easier to process larger amount of output. The action allows for the user to enable the generation of an artifact.

The optional `output_file` input parameter, if specified, defines the name of the generated file containing the spellcheck output. Such file can then be stored as workflow artifact using the `actions/upload-artifact` step.

A configuration for emitting an output artifact could look as follows.

Example:

```yaml
name: Spellcheck Action
on: push

jobs:
  build:
    name: Spellcheck
    runs-on: ubuntu-latest
    steps:
    # The checkout step
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.24.0
      name: Spellcheck
      with:
        source_files: README.md CHANGELOG.md notes/Notes.md
        task_name: Markdown
        output_file: spellcheck-output.txt
```

The artifact can be downloaded via the GitHub UI or via the GitHub API. The artifact is names: `Spellcheck artifact`, based on the name of the workflow (see above example).

Do see the [official documentation](https://docs.github.com/en/rest/actions/artifacts#about-the-artifacts-api) for handling artifacts via the API.

Artifacts are by default available for 3 months.

### Extra Configuration

#### Extra Configuration for PySpelling

Do check the [PySpelling documentation][pyspelling] for elaborate details on configuration of [PySpelling][pyspelling].

#### Extra Configuration for Markdown

[PySpelling][pyspelling] uses the [Python Markdown][markdown] project. [PySpelling][pyspelling] allows for configuration of the Markdown handling using the `[pymdown-extensions]` authored by the author of [PySpelling][pyspelling].

If for example wanted to use the `superfences` extension, you could configure it as follows:

```yaml
  - pyspelling.filters.markdown:
      markdown_extensions:
      - pymdownx.superfences:
```

Current Spellcheck Action support the following extensions (_in alphabetical order_):

- Arithmatex
- B64
- BetterEm
- Caret
- Critic
- Details
- Emoji
- EscapeAll
- Extra
- Highlight
- InlineHilite
- Keys
- MagicLink
- Mark
- PathConverter
- ProgressBar
- SaneHeaders
- SmartSymbols
- Snippets
- StripHTML
- SuperFences
- Tabbed
- Tasklist
- Tilde

Please consult [the documentation](https://facelessuser.github.io/pymdown-extensions/) for the extensions for more details.

Currently only the case of use of `superfences` has been requested as outlined in the above example.

Do also see the Diagnostics sections below, demonstrating diagnostics emitted from [Python Markdown][markdown], which might require the use of an extension.

## Spellcheck Configuration File

You can either provide a path to the configuration file or save a file in the root of your repository with a predefined name (list below). If `config_path` is provided then it will be used and the other configuration options will be ignored. If `config_path` is not provided then the repository is searched after a first match

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
    - uses: rojopolis/spellcheck-github-actions@0.24.0
      name: Spellcheck
      with:
        config_path: config/.spellcheck.yml # put path to configuration file here
        source_files: source/scanning.md source/triggers.md
        task_name: Markdown
```

### Predefined Name

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

## Specifying Language

This action currently only support `aspell`, please see the section on Language Support below.

In the section for `aspell` you can specify the main language, for example `en`, via the `lang` parameter.

You can further specify dialect, using the `d` parameter.

See the documentation for [PySpelling](https://facelessuser.github.io/pyspelling/configuration/#spell-checker-options) for more details.

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

## Language Support

Currently only the following languages are supported via [GNU Aspell][aspell]:

- English via the [`aspell-en` Debian package][aspell-en], supporting:
  - American (`en_US`),
  - British (`en_GB`),
  - Canadian (`en_CA`)
  - and Australian (`en_AU`)
- German via the [`aspell-de` Debian package][aspell-de], supporting:
  - German (`de_DE`),
  - Swiss (`de_CH`)
  - Austrian (`de_AT`)
- Spanish via the [`aspell-es` Debian package][aspell-es]

Additional languages can be added by request, please open an issue.

[Hunspell][hunspell] is supported by [PySpelling][pyspelling], but is **not** currently supported by this action

Please open an issue or PR, if [Hunspell][hunspell] should be evaluated for possible inclusion.

## Tips

## Specify Code Not To Have Spelling Checked

Since this action checks all available text, you might run into problems with section of code examples etc.

This can be circumvented by the following configuration:

```yaml
      ignores:
      - code
      - pre
```

This works on the intermediate HTML form of the data.

A complete configuration could look as follows:

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

And `code` and `pre` sections are ignored by the spelling check.

### Getting Your Action Updated Automatically

The _awesome_ tool dependabot lets you scan your used GitHub Marketplace Actions and lets you know if they are in need of an update.

The update is proposed via a pull request, which can be accepted or declined, it will itself take care of deleting pull requests if these become irrelevant.

You specify the configuration in the file: `.github/dependabot.yml` in your repository using this action - actually it scans all your actions.

```yaml
# Basic dependabot.yml file
# REF: https://docs.github.com/en/code-security/supply-chain-security/keeping-your-actions-up-to-date-with-dependabot

version: 2
updates:
  # Enable version updates for Actions
  - package-ecosystem: "github-actions"
    # Look for `.github/workflows` in the `root` directory
    directory: "/"
    # Check for updates once a week
    schedule:
      interval: "weekly"
```

### Slimming Your Wordlist By Ignoring Case

This tip works for `aspell`.

You can slim down your `.wordlist.txt` file if you have case variations of entries of words.

```yaml
aspell:
    ignore-case: true
```

To convert you existing `.wordlist.txt` you could do something along the lines of this using Bash version 4.

```bash
$ tr '[:upper:]' '[:lower:]' < .wordlist.txt > temp-wordlist.txt
$ cat temp-wordlist.txt | sort -u > .wordlist.txt
$ rm temp-wordlist.txt
```

And you should be good to go.

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
1. Or set `expect_match` to `false`

```yaml
matrix:
- name: markdown
  pipeline:
  - pyspelling.filters.text
  sources:
  - '**/*.md'
  expect_match: false
  default_encoding: utf-8
```

Please see the documentation for [Wildcard Match][wcmatch] (1 and 2) or [Expect Match][expectmatch].

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

If the file is available in the repository, please check that your workflow is configured correctly, with the following line, which enables [the action: checkout][actioncheckout].

`uses: actions/checkout@master`

In full context:

```yaml
name: Spellcheck Action
on: push

jobs:
  build:
    name: Spellcheck
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: rojopolis/spellcheck-github-actions@0.24.0
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

Please see the repository's `requirements.txt` for a list of all included Python modules and their exact versions.

### Diagnostic text: `ValueError: Pipline step in unexpected format:`

This error emitted from `pyspelling` indicates issues with the configuration file.

Please see the section: "Configuration" above.

With the update of [pyspelling](https://pypi.org/project/pyspelling/) from 2.6.1 to 2.7.3 with release 0.16.0  (0.15.0, do see the change log).

This error would be emitted from the GitHub Action, if the configuration was not properly formatted. The Markdown example's earlier revisions in this repository would demonstrate the error.

To address the error, the options below the filter should be properly indented.

```yaml
  - pyspelling.filters.html:
    comments: false
    ignores:
    - code
    - pre
```

Should be indented to:

```yaml
  - pyspelling.filters.html:
      comments: false
      ignores:
      - code
      - pre
```

The complete error emitted could would look something along the lines of:

```text
Traceback (most recent call last):
  File "/usr/local/bin/pyspelling", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/pyspelling/__main__.py", line 30, in main
    return run(
  File "/usr/local/lib/python3.9/site-packages/pyspelling/__main__.py", line 55, in run
    for results in spellcheck(
  File "/usr/local/lib/python3.9/site-packages/pyspelling/__init__.py", line 673, in spellcheck
    for result in spellchecker.run_task(task, source_patterns=sources):
  File "/usr/local/lib/python3.9/site-packages/pyspelling/__init__.py", line 311, in run_task
    self._build_pipeline(task)
  File "/usr/local/lib/python3.9/site-packages/pyspelling/__init__.py", line 255, in _build_pipeline
    raise ValueError(STEP_ERROR.format(str(step)))
ValueError: Pipline step in unexpected format: {'pyspelling.filters.html': None, 'comments': False, 'ignores': ['code', 'pre']}
```

Example lifted from issue [#60](https://github.com/rojopolis/spellcheck-github-actions/issues/60)

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
$ docker run -it -v $PWD:/tmp github-action-spellcheck
```

## Resources and References

- [GNU Aspell][aspell]
- [Hunspell][hunspell]
- [PySpelling][pyspelling]

## Author

The original author of this GitHub Action is Robert Jordan (@rojopolis)

## Acknowledgements

Here follows a list of contributors in alphabetical order:

- @aSemy
- Albert Volkman, @albertvolkman
- Byron Miller, @supernovae
- Isaac Muse, @facelessuser
- Jonas Brømsø, @jonasbn
- José Eduardo Montenegro Cavalcanti de Oliveira, @edumco
- Matt Calvert, @miff2000
- Michael Flaxman, @mflaxman
- Mike Starov, @xsaero00
- Pavel Skipenes, @pavelskipenes
- Peter Petrik, @PeterPetrik
- Riccardo Porreca, @riccardoporreca
- Stephen Bates, @sbates130272

Do you want to be left out, or feel left out of this list or have a different representation of your name, please submit a pull request or raise an issue

## Copyright and License

This repository is licensed under the MIT license.

[pyspelling]: https://facelessuser.github.io/pyspelling/
[wcmatch]: https://facelessuser.github.io/wcmatch/glob/
[actioncheckout]: https://github.com/marketplace/actions/checkout
[markdown]: https://pypi.org/project/Markdown/
[pymdown-extensions]: https://pypi.org/project/pymdown-extensions/
[hunspell]: http://hunspell.github.io/
[aspell]: http://aspell.net/
[aspell-de]: https://packages.debian.org/buster/aspell-de
[aspell-en]: https://packages.debian.org/buster/aspell-en
[aspell-es]: https://packages.debian.org/buster/aspell-es
[GHAMKDBADGE]: https://github.com/rojopolis/spellcheck-github-actions/workflows/Markdownlint%20Action/badge.svg
[GHASPLLBADGE]: https://github.com/rojopolis/spellcheck-github-actions/workflows/Spellcheck%20Action/badge.svg
[expect_match]: https://facelessuser.github.io/pyspelling/configuration/#expect-match
