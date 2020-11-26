FROM ruby:2.5.7-stretch

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /application
RUN gem install bundler -v 2.1.4
COPY ./Gemfile /application/Gemfile
COPY ./Gemfile.lock /application/Gemfile.lock
RUN bundle install
COPY . /application

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]