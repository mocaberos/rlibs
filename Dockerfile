FROM ruby:3.0.2-bullseye

WORKDIR /app
COPY . /app

RUN bundle install --jobs=3 --retry=3
