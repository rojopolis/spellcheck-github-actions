FROM python:3.9.1-slim

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/rojopolis/spellcheck-github-actions"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="rojopolis <rojo@deba.cl>"

RUN apt-get update \
    && apt-get install -y --no-install-recommends aspell \
    aspell-am \
    aspell-ar \
    aspell-bg \
    aspell-bn \
    aspell-br \
    aspell-ca \
    aspell-cs \
    aspell-cy \
    aspell-da \
    aspell-de \
    aspell-el \
    aspell-en \
    aspell-eo \
    aspell-es \
    aspell-et \
    aspell-eu \
    aspell-fa \
    aspell-fo \
    aspell-fr \
    aspell-ga \
    aspell-gl-minimos \
    aspell-gu \
    aspell-he \
    aspell-hi \
    aspell-hr \
    aspell-hsb \
    aspell-hu \
    aspell-hy \
    aspell-is \
    aspell-it \
    aspell-kk \
    aspell-kn \
    aspell-ku \
    aspell-lt \
    aspell-lv \
    aspell-ml \
    aspell-mr \
    aspell-nl \
    aspell-no \
    aspell-or \
    aspell-pa \
    aspell-pl \
    aspell-pt-br \
    aspell-pt-pt \
    aspell-ro \
    aspell-ru \
    aspell-sk \
    aspell-sl \
    aspell-ta \
    aspell-te \
    aspell-sv \
    aspell-tl \
    aspell-uk \
    aspell-uz \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt

RUN pip3 install -r requirements.txt

COPY spellcheck.yaml /spellcheck.yaml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /tmp
ENTRYPOINT ["/entrypoint.sh"]
