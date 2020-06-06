FROM python:3.7-alpine3.12

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

RUN apk add --no-cache aspell build-base libxml2-dev libxslt-dev && \
	pip3 install pyspelling && \
	apk del build-base libxml2-dev libxslt-dev

COPY spellcheck.yaml /spellcheck.yaml

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /tmp

ENTRYPOINT ["/entrypoint.sh"]
