# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
# Rails app lives here
RUN mkdir -p /rails
WORKDIR /rails

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

RUN apt-get update && apt-get install libpq-dev

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN rails assets:clean assets:precompile

# Copy the main application.
COPY . ./
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.

CMD ["rails", "server", "-b", "0.0.0.0"]