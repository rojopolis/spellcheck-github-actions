#!/bin/sh -l

SPELLCHECK_CONFIG_FILE=''
WORDLIST_FILE=''

if [ -f "./.spellcheck.yml" ]; then
    SPELLCHECK_CONFIG_FILE=".spellcheck.yml"
elif [ -f "./.spellcheck.yaml" ]; then
    SPELLCHECK_CONFIG_FILE=".spellcheck.yaml"
elif [ -f "./spellcheck.yml" ]; then
    SPELLCHECK_CONFIG_FILE="spellcheck.yml"
else
    SPELLCHECK_CONFIG_FILE="spellcheck.yaml"
fi

if [ -f "./worldlist.txt" ]; then
    WORDLIST_FILE="wordlist.txt"
else
    WORDLIST_FILE=".wordlist.txt"
fi

if [ ! -f $WORDLIST_FILE ]; then
    echo "No $WORDLIST_FILE defined so we define an empty one"
    touch $WORDLIST_FILE
fi

echo ""
echo "Using pyspelling on repository files outlined in >$SPELLCHECK_CONFIG_FILE<"
echo "Word list read from >$WORDLIST_FILE<"
echo "----------------------------------------------------------------"

pyspelling --config $SPELLCHECK_CONFIG_FILE

EXITCODE=$?

test $EXITCODE -gt 1 && echo "($EXITCODE) Spelling check action failed, please check diagnostics";

test $EXITCODE -eq 1 && echo "($EXITCODE) Files in repository contain spelling errors";

exit $EXITCODE
