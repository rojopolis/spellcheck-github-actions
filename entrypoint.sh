#!/bin/sh -l

SPELLCHECK_CONFIG_FILE=''

if [ -f ./.spellcheck.yaml ]; then
    SPELLCHECK_CONFIG_FILE='spellcheck.yaml'
fi

if [ -f ./.spellcheck.yml ]; then
    SPELLCHECK_CONFIG_FILE='.spellcheck.yml'
fi

echo ""
echo "Using pyspelling on repository files outlined in $SPELLCHECK_CONFIG_FILE"
echo "----------------------------------------------------------------"

pyspelling -c $SPELLCHECK_CONFIG_FILE

EXITCODE=$?

test $EXITCODE -eq 0 || echo "($EXITCODE) Repository contains spelling errors or spelling check failed, please check diagnostics";

exit $EXITCODE
