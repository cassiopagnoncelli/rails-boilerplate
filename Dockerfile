# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.1.0
ARG BUNDLE_VERSION=2.3.3

###############################################################################
# Base stage
FROM ruby:${RUBY_VERSION}-slim as base

ARG APP_DIR=/src
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} -r app && useradd -u ${UID} -r -g app app

ENV APP_DIR ${APP_DIR}
WORKDIR $APP_DIR

RUN chown ${UID}:${GID} ${APP_DIR}

# https://github.com/docker-library/docs/tree/master/ruby#encoding
ENV LANG C.UTF-8

# Add missing man dirs in debian slim. Some packages break when they are missing.
RUN bash -c 'mkdir -p /usr/share/man/man{1..8}'

# This is required to install the other dependencies
RUN apt-get update && apt-get install -y tini gnupg curl apt-transport-https \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*.log /var/cache/debconf/*-old

ENV BUNDLE_PATH vendor/bundle

###############################################################################
# Build stage
FROM base as build

ARG BUNDLE_VERSION

ENV BUNDLE_VERSION ${BUNDLE_VERSION}

# System deps for app
RUN apt-get update \
	&& apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev postgresql-client shared-mime-info git \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*.log /var/cache/debconf/*-old

RUN gem install bundler -v ${BUNDLE_VERSION}

###############################################################################
# Bundle stage
FROM build as bundle

ARG BUNDLE_GITHUB__COM

ENV BUNDLE_DEPLOYMENT 1
ENV BUNDLE_CLEAN 1
ENV BUNDLE_DISABLE_SHARED_GEMS 1
ENV BUNDLE_FROZEN 1
ENV BUNDLE_JOBS 5
ENV BUNDLE_GITHUB__COM=${BUNDLE_GITHUB__COM}

COPY --chown=app:app Gemfile Gemfile.lock ./
RUN bundle install

###############################################################################
# Release stage
FROM base as release

ARG APP_VERSION
ENV APP_VERSION ${APP_VERSION}

ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES 1

ENV PORT 3000
EXPOSE ${PORT}

COPY --from=build /usr/lib/x86_64-linux-gnu/libpq.so* /usr/lib/x86_64-linux-gnu/
COPY --chown=app:app --from=bundle $APP_DIR/vendor/bundle vendor/bundle
COPY --chown=app:app . .

USER app

RUN RAILS_ENV=production bin/rails tmp:create
RUN RAILS_ENV=production LOG_LEVEL=debug SECRET_KEY_BASE=whatever SKIP_REDIS=1 bin/rails assets:precompile

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
