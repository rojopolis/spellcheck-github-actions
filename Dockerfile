# REF: https://hub.docker.com/_/python
# Python 3.14.2-slim-trixie
FROM python:3.14.2-slim-trixie@sha256:3955a7dd66ccf92b68d0232f7f86d892eaf75255511dc7e98961bdc990dc6c9b

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repository"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="https://github.com/marketplace/actions/github-spellcheck-action"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"
LABEL "maintainer"="jonasbn <jonasbn@gmail.com>"

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY constraint.txt /constraint.txt
COPY spellcheck.yaml /spellcheck.yaml
COPY pwc.py /pwc.py

# REF: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update && apt-get install -y \
    build-essential pkg-config \
    libxml2-dev libxslt1-dev \
    zlib1g-dev \
    aspell hunspell \
    aspell-en hunspell-en-au hunspell-en-ca hunspell-en-gb hunspell-en-us \
    aspell-de hunspell-de-at hunspell-de-ch hunspell-de-de \
    aspell-es hunspell-es \
    aspell-fr hunspell-fr \
    aspell-ru hunspell-ru \
    aspell-uk hunspell-uk \
    aspell-it hunspell-it \
    aspell-pt-pt aspell-pt-br hunspell-pt-pt hunspell-pt-br \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PIP_CONSTRAINT=/constraint.txt
RUN pip3 install -r /requirements.txt

WORKDIR /tmp
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
