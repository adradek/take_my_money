FROM ruby:2.7
LABEL maintainer="alex.kochurov@gmail.com"

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

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
