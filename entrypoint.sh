#!/bin/bash

SPELLCHECK_CONFIG_FILE=''

if [ -n "$INPUT_CONFIG_PATH" ]; then
    SPELLCHECK_CONFIG_FILE=$INPUT_CONFIG_PATH
else
    if [ -f "./.spellcheck.yml" ]; then
        SPELLCHECK_CONFIG_FILE=".spellcheck.yml"
    elif [ -f "./.spellcheck.yaml" ]; then
        SPELLCHECK_CONFIG_FILE=".spellcheck.yaml"
    elif [ -f "./spellcheck.yml" ]; then
        SPELLCHECK_CONFIG_FILE="spellcheck.yml"
    elif [ -f "./spellcheck.yaml" ]; then
        SPELLCHECK_CONFIG_FILE="spellcheck.yaml"
    elif [ -f "./.pyspelling.yaml" ]; then
        SPELLCHECK_CONFIG_FILE=".pyspelling.yaml"
    elif [ -f "./.pyspelling.yml" ]; then
        SPELLCHECK_CONFIG_FILE=".pyspelling.yml"
    else
        SPELLCHECK_CONFIG_FILE="spellcheck.yaml"
    fi
fi

echo ""
echo "Using pyspelling on configuration outlined in >$SPELLCHECK_CONFIG_FILE<"
pyspelling --version
aspell --version
hunspell --version
echo "----------------------------------------------------------------"

SINGLE="'"
DOUBLE='"'
SPLIT=false

if [ -n "$INPUT_SOURCE_FILES" ]; then

    echo "Source files to check: >$INPUT_SOURCE_FILES<"

    if grep -q $SINGLE <<< "$INPUT_SOURCE_FILES"; then
        OIFS=$IFS
        IFS=$SINGLE
        SPLIT=true
        echo "Detected separator: >$SINGLE< (single quote)"
    fi

    if grep -q $DOUBLE <<< "$INPUT_SOURCE_FILES"; then
        OIFS=$IFS
        IFS=$DOUBLE
        SPLIT=true
        echo "Detected separator: >$DOUBLE< (double quote)"
    fi

    if [ -z "$INPUT_TASK_NAME" ]; then
        echo "task_name must be specified to use source_files option"
        exit 1
    else
        echo "Running task >$INPUT_TASK_NAME<"
    fi

    if [ "$SPLIT" = true ]; then
        echo "IFS = >$IFS<"
        read -r -a arr <<< "$INPUT_SOURCE_FILES"

        for FILE in "${arr[@]}"; do

            echo "$FILE" | python3 /pwc.py "$SPELLCHECK_CONFIG_FILE"

            PATTERN_MATCH_EXITCODE=$?

            if [ $PATTERN_MATCH_EXITCODE -eq 1 ]; then
                echo "Skipping file >$FILE<"
                continue
            fi

            # Skip null items
            if [ -z "$FILE" ]; then
                continue
            fi

            if [ "$FILE" = ' ' ]; then
                continue
            fi

            SOURCES_LIST="$SOURCES_LIST --source $FILE"
            echo "Checking quoted file >$FILE<"

        done

        IFS=$OIFS
        unset OIFS

    else
        read -r -a arr <<< "$INPUT_SOURCE_FILES"

        for FILE in "${arr[@]}"; do
            echo "$FILE" | python3 /pwc.py "$SPELLCHECK_CONFIG_FILE"

            PATTERN_MATCH_EXITCODE=$?

            if [ $PATTERN_MATCH_EXITCODE -eq 1 ]; then
                echo "Skipping file >$FILE<"
                continue
            fi
            SOURCES_LIST="$SOURCES_LIST --source $FILE"
            echo "Checking file >$FILE<"
        done
    fi

    echo "Checking files specification in sources_list as: >$SOURCES_LIST<"

else
    echo "Checking files matching specification outlined in: >$SPELLCHECK_CONFIG_FILE<"
fi

if [ -n "$INPUT_TASK_NAME" ]; then
    TASK_NAME="--name $INPUT_TASK_NAME"
fi

SPELL_CHECKER='aspell'
if [ -n "$INPUT_SPELL_CHECKER" ]; then
    if [ "${INPUT_SPELL_CHECKER,,}" = "hunspell" ]; then # lowercased INPUT_SPELL_CHECKER for caseinsensitive compare
        echo "Using hunspell as spell checker via action configuration"
        SPELL_CHECKER="hunspell"
    elif [ "${INPUT_SPELL_CHECKER,,}" = "aspell" ]; then # lowercased INPUT_SPELL_CHECKER for caseinsensitive compare
        echo "Using aspell as spell checker via action configuration"
    else
        echo "Using aspell as spell checker by default"
    fi
fi

EXITCODE=0

# shellcheck disable=SC2086
# Command line template
# pyspelling --verbose --config "$SPELLCHECK_CONFIG_FILE" --spellchecker "$SPELL_CHECKER" --name $TASK_NAME --source $SOURCES_LIST
# source and name are included in the parameters used

if [ -n "$INPUT_OUTPUT_FILE" ] && [ -n "$SOURCES_LIST" ]; then
    pyspelling --verbose --config "$SPELLCHECK_CONFIG_FILE" --spellchecker "$SPELL_CHECKER" $TASK_NAME $SOURCES_LIST | tee "$INPUT_OUTPUT_FILE"
    EXITCODE=${PIPESTATUS[0]}
elif [ -n "$INPUT_OUTPUT_FILE" ]; then
    pyspelling --verbose --config "$SPELLCHECK_CONFIG_FILE" --spellchecker "$SPELL_CHECKER" $TASK_NAME | tee "$INPUT_OUTPUT_FILE"
    EXITCODE=${PIPESTATUS[0]}
elif [ -n "$SOURCES_LIST" ]; then
    pyspelling --verbose --config "$SPELLCHECK_CONFIG_FILE" --spellchecker "$SPELL_CHECKER" $TASK_NAME $SOURCES_LIST
    EXITCODE=$?
elif [ -z "$INPUT_SOURCE_FILES" ]; then
    pyspelling --verbose --config "$SPELLCHECK_CONFIG_FILE" --spellchecker "$SPELL_CHECKER" $TASK_NAME
    EXITCODE=$?
else
    echo "No files to check, exiting"
    EXITCODE=0
fi

echo "----------------------------------------------------------------"

if [ -n "$GITHUB_ACTIONS" ]; then
    test "$EXITCODE" -gt 1 && echo "::error title=Spelling check::Spelling check action failed, please check diagnostics";

    test "$EXITCODE" -eq 1 && echo "::error title=Spelling errors::Files in repository contain spelling errors";
else
    test "$EXITCODE" -gt 1 && echo "Spelling check action failed, please check diagnostics";

    test "$EXITCODE" -eq 1 && echo "Files in repository contain spelling errors";
fi

exit "$EXITCODE"
