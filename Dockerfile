FROM python:3.9.1-slim

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends aspell aspell-en \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt

RUN pip3 install -r requirements.txt

COPY spellcheck.yaml /spellcheck.yaml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp
ENTRYPOINT ["/entrypoint.sh"]
