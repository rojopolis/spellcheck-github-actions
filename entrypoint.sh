#!/bin/sh -l

SPELLCHECK_CONFIG_FILE=''

echo ""
echo "Using pyspelling on repository files outlined in $SPELLCHECK_CONFIG_FILE"
echo "------------------------------------------------------------------------"

pyspelling -c $SPELLCHECK_CONFIG_FILE

#!/bin/bash

SPELLCHECK_CONFIG_FILE=''

if [ ! -f "./spellcheck.yaml" ]; then
    if [ -f "./.spellcheck.yaml" ]; then
	    cp ./.spellcheck.yaml spellcheck.yaml
        SPELLCHECK_CONFIG_FILE='.spellcheck.yaml'

    else
	    cp /spellcheck.yaml .
        SPELLCHECK_CONFIG_FILE='spellcheck.yaml'
    fi
elif

fi

if [ ! -f ./wordlist.txt ]; then
    if [ -f "./.worldlist.txt" ]; then
	    cp ./.wordlist.txt wordlist.txt
    else
	    cp /wordlist.txt .
    fi
fi

echo ""
echo "Using pyspelling on repository files outlined in $SPELLCHECK_CONFIG_FILE"
echo "----------------------------------------------------------------"

pyspelling -c spellcheck.yaml

EXITCODE=$?

test $EXITCODE -eq 0 || echo "($EXITCODE) Repository contains spelling errors or spelling check failed, please check diagnostics";

exit $EXITCODE
