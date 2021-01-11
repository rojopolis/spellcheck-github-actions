#!/bin/sh -l

SPELLCHECK_CONFIG_FILE=''

if [ -n $INPUT_CONFIG_PATH ]; then
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
echo "Using pyspelling on repository files outlined in >$SPELLCHECK_CONFIG_FILE<"
echo "----------------------------------------------------------------"

pyspelling --config $SPELLCHECK_CONFIG_FILE

EXITCODE=$?

test $EXITCODE -gt 1 && echo "Spelling check action failed, please check diagnostics";

test $EXITCODE -eq 1 && echo "Files in repository contain spelling errors";

exit $EXITCODE
