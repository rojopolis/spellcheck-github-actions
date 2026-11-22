#!python3

# Renders pyspelling's console output as a markdown table, for use as a
# GitHub Actions job summary (GITHUB_STEP_SUMMARY), similar to what
# lychee-action does for its own results. See:
# https://github.com/facelessuser/pyspelling/blob/main/pyspelling/__main__.py
# for the exact text format this parses.

import sys

SEPARATOR = '-' * 80


def split_file_and_detail(context):
    if ': ' in context:
        file_part, _, detail_part = context.partition(': ')
        return file_part, detail_part
    return context, ''


def escape_cell(text):
    return text.replace('|', '\\|').replace('\n', ' ')


def parse(lines):
    rows = []
    passed = None

    i = 0
    n = len(lines)
    while i < n:
        line = lines[i].rstrip('\n')

        if line.startswith('ERROR: ') and ' -- ' in line:
            context, _, error = line[len('ERROR: '):].partition(' -- ')
            rows.append({'type': 'error', 'context': context, 'detail': error})
            i += 1
            continue

        if line == 'Misspelled words:':
            i += 1
            context_line = lines[i].rstrip('\n') if i < n else ''
            category = ''
            context = context_line
            if context_line.startswith('<') and '> ' in context_line:
                category, _, context = context_line[1:].partition('> ')
            i += 1

            if i < n and lines[i].rstrip('\n') == SEPARATOR:
                i += 1

            words = []
            while i < n and lines[i].rstrip('\n') != SEPARATOR:
                word = lines[i].rstrip('\n')
                if word:
                    words.append(word)
                i += 1

            if i < n and lines[i].rstrip('\n') == SEPARATOR:
                i += 1

            rows.append({'type': 'words', 'category': category, 'context': context, 'words': words})
            continue

        if line == 'Spelling check passed :)':
            passed = True
        elif line == '!!!Spelling check failed!!!':
            passed = False

        i += 1

    return rows, passed


def render(rows, passed):
    out = ['### Spellcheck Results', '']

    if not rows:
        if passed:
            out.append(':white_check_mark: No spelling issues found.')
        else:
            out.append(':warning: Spelling check output could not be parsed into a summary.')
        return '\n'.join(out) + '\n'

    out.append('| File | Context | Issue |')
    out.append('| --- | --- | --- |')
    for row in rows:
        file_part, detail_part = split_file_and_detail(row['context'])
        if row['type'] == 'error':
            issue = f"Error: {escape_cell(row['detail'])}"
        else:
            issue = ', '.join(f'`{escape_cell(word)}`' for word in row['words'])
        out.append(f'| {escape_cell(file_part)} | {escape_cell(detail_part)} | {issue} |')

    out.append('')
    if passed is False:
        out.append(':x: Spelling check failed.')
    elif passed is True:
        out.append(':white_check_mark: Spelling check passed.')

    return '\n'.join(out) + '\n'


def main():
    capture_file = sys.argv[1]
    with open(capture_file, encoding='utf-8', errors='replace') as f:
        lines = f.readlines()

    rows, passed = parse(lines)
    print(render(rows, passed))


if __name__ == '__main__':
    main()
