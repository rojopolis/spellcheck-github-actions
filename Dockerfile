# REF: https://hub.docker.com/_/python
FROM python:3.13.2-slim-bookworm

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repository"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="https://github.com/marketplace/actions/github-spellcheck-action"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY constraint.txt /constraint.txt
COPY spellcheck.yaml /spellcheck.yaml
COPY pwc.py /pwc.py

ENV PIP_CONSTRAINT=/constraint.txt
RUN pip3 install -r /requirements.txt

# REF: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update && apt-get install -y \
    aspell aspell-en aspell-de aspell-es aspell-fr aspell-ru aspell-uk \
    hunspell \
    hunspell-en-au hunspell-en-ca hunspell-en-gb hunspell-en-us \
    hunspell-de-at hunspell-de-ch hunspell-de-de \
    hunspell-es hunspell-fr \
    hunspell-ru hunspell-uk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
