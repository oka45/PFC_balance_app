FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

WORKDIR /PFC_balance_app

COPY Gemfile /PFC_balance_app/Gemfile
COPY Gemfile.lock /PFC_balance_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /PFC_balance_app
