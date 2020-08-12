FROM ruby:2.6.2

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

ENV RAILS_ENV production

COPY . ./

EXPOSE 3000
CMD bundle exec puma -C config/puma.rb
