# default are English and German
ARG SPELLCHECK_LANGS="en,de"

# Builder stage: configure env vars, labels, add plain files, install common packages
FROM python:3.9.6-slim as spellcheck-builder

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"
# label as builder stage, for easy cleanup (e.g. `docker image prune --filter label=stage=builder`)
LABEL stage=builder

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt
COPY spellcheck.yaml /spellcheck.yaml
RUN pip3 install -r /requirements.txt

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get
RUN apt-get update && apt-get install -y \
    aspell \
    && rm -rf /var/lib/apt/lists/*

######################################################################################################

# Custom built images with an arg
FROM spellcheck-builder as spellcheck

RUN apt-get update && apt-get install -y \
    aspell \
    # split arg SPELLCHECK_LANGS to space separated, and prepend each with 'aspell-'
    $(echo "$SPELLCHECK_LANGS" | sed 's/,/ /g' | xargs printf -- 'aspell-%s\n')     \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
