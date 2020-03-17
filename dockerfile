FROM ruby:2.6.5-alpine

RUN apk add --update build-base postgresql-dev tzdata git
RUN gem install rails -v '6.0.2'

WORKDIR /app

ADD Gemfile Gemfile.lock /app/
RUN gem install bundler:2.1.4
RUN bundle install
