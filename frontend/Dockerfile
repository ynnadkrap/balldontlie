FROM ruby:2.4 AS build

RUN apt-get update && apt-get install -y nodejs

WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./
RUN bundle exec middleman build --clean


FROM nginx:stable

COPY --from=build /app/build/ /var/www
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD "nginx"
