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

echo ""
echo "Using pyspelling on configuration outlined in >$SPELLCHECK_CONFIG_FILE<"

if [ -n "$INPUT_SOURCE_FILES" ]; then
    if [ -z "$INPUT_TASK_NAME" ]; then
        echo "task_name must be specified to use source_files option"
        exit 1
    else
        echo "Running task >$INPUT_TASK_NAME<"
    fi
    for FILE in $INPUT_SOURCE_FILES; do
        SOURCES_LIST="$SOURCES_LIST --source $FILE"
        echo "Checking file >$FILE<"
    done
else
    echo "Checking files matching specified outlined in >$SPELLCHECK_CONFIG_FILE<"
fi

if [ -n "$INPUT_TASK_NAME" ]; then
    TASK_NAME="--name $INPUT_TASK_NAME"
fi

echo "----------------------------------------------------------------"

pyspelling --config $SPELLCHECK_CONFIG_FILE $TASK_NAME $SOURCES_LIST

EXITCODE=$?

test $EXITCODE -gt 1 && echo "::error title=Spelling check::Spelling check action failed, please check diagnostics";

test $EXITCODE -eq 1 && echo "::error title=Spelling errors::Files in repository contain spelling errors";

exit $EXITCODE
