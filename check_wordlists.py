#!python3

# Verifies that every wordlist file declared in a spellcheck configuration's
# `dictionary.wordlists` actually exists, so a missing file produces a clear
# message instead of a raw Traceback from PySpelling's own dictionary
# compilation step (FileNotFoundError in pyspelling.compile_dictionary).

import sys

import yaml


def read_yaml(file):
    with open(file) as f:
        return yaml.safe_load(f)


def find_missing_wordlists(config_file):
    data = read_yaml(config_file)

    missing = []
    for task in data.get('matrix', []):
        dictionary = task.get('dictionary')
        if not dictionary:
            continue

        task_name = task.get('name', '<unnamed task>')
        for wordlist in dictionary.get('wordlists', []):
            try:
                with open(wordlist, 'rb'):
                    pass
            except OSError:
                missing.append((task_name, wordlist))

    return missing


def main():
    config_file = sys.argv[1]
    missing = find_missing_wordlists(config_file)

    for task_name, wordlist in missing:
        print(
            f"You have declared the wordlist file '{wordlist}' in the "
            f"'{task_name}' task of '{config_file}' but it was not found. "
            f"Remove the file declaration from '{config_file}' or create "
            f"the file with the same name."
        )

    return 1 if missing else 0


if __name__ == '__main__':
    sys.exit(main())
