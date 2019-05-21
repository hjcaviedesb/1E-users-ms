FROM seapy/ruby:2.6.1

RUN apt-get update -q
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN apt-get install libmysqlclient-dev
RUN apt-get install -y --force-yes libpq-dev

RUN gem install bundler
RUN gem install rails

ADD ./ /rails

WORKDIR /rails

ENV RAILS_ENV production
ENV PORT 8080

RUN /bin/bash -l -c "bundle install --without development test"

EXPOSE 8080

CMD bundle exec rake db:create db:migrate assets:precompile && foreman start -f Procfile
