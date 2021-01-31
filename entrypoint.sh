#!/bin/sh -l

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
    else
        SPELLCHECK_CONFIG_FILE="spellcheck.yaml"
    fi
fi

if [ -n "$INPUT_SOURCE_FILES" ]; then
    if [ -z "$INPUT_TASK_NAME" ]; then
        echo "task_name must be specified to use source_files option"
        exit 1
    fi
    for FILE in $INPUT_SOURCE_FILES; do
        SOURCES_LIST="$SOURCES_LIST --source $FILE"
    done  
fi

if [ -n "$INPUT_TASK_NAME" ]; then
    TASK_NAME="--name $INPUT_TASK_NAME"
fi

echo ""
echo "Using pyspelling on repository files outlined in >$SPELLCHECK_CONFIG_FILE<"
echo "----------------------------------------------------------------"

pyspelling --config $SPELLCHECK_CONFIG_FILE $TASK_NAME $SOURCES_LIST

EXITCODE=$?

test $EXITCODE -gt 1 && echo "Spelling check action failed, please check diagnostics";

test $EXITCODE -eq 1 && echo "Files in repository contain spelling errors";

exit $EXITCODE
