#!/bin/bash
if [ ! -f ./spellcheck.yaml ]; then
    cp /spellcheck.yaml .
fi

pyspelling -c spellcheck.yaml