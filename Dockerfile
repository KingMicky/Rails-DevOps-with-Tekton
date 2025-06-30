FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /my-app/rails-app
COPY my-app/rails-app/Gemfile* ./
RUN bundle install

WORKDIR /my-app
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
