#!/bin/bash

if [ ! -f "./spellcheck.yaml" ]; then
    if [ -f "./.spellcheck.yaml" ]; then
	cp ./.spellcheck.yaml spellcheck.yaml
    else
	cp /spellcheck.yaml .
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

pyspelling -c spellcheck.yaml
