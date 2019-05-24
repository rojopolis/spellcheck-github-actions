#!/bin/bash
if [ ! -f ./spellcheck.yaml ]; then
    cp /spellcheck.yaml .
fi

if [ ! -f ./wordlist.txt ]; then
    cp /wordlist.txt .
fi

pyspelling -c spellcheck.yaml