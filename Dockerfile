FROM python:3.7

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

RUN apt-get update && apt-get install -y \
    aspell \
 && rm -rf /var/lib/apt/lists/*
RUN pip3 install pyspelling
COPY entrypoint.sh /entrypoint.sh
COPY spellcheck.yaml /spellcheck.yaml
COPY wordlist.txt /wordlist.txt
ENTRYPOINT ["/entrypoint.sh"]