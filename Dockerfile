FROM debian:9.5-slim

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="thumbs-up"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

RUN apt-get update && apt-get install -y \
    python3 \
 && rm -rf /var/lib/apt/lists/*

ADD entrypoint.py /entrypoint.py
ENTRYPOINT ["/entrypoint.py"]