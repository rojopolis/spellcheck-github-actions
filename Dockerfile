# REF: https://hub.docker.com/_/python
FROM python:3.11.4-slim-bullseye

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repository"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY spellcheck.yaml /spellcheck.yaml
RUN pip3 install -r /requirements.txt

# REF: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update && apt-get install -y \
    aspell aspell-en aspell-de aspell-es aspell-fr \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
