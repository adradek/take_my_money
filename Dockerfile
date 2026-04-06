FROM ruby:2.5
LABEL maintainer="alex.kochurov@gmail.com"

RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs

WORKDIR /usr/src/app

ARG UID
ARG GID

RUN groupadd -g $GID alexey && \
    useradd -m -s /bin/bash -u $UID -g $GID alexey && \
    chown -R alexey:alexey /usr/src/app

USER alexey

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
