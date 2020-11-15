FROM ruby:2.7.2-alpine

WORKDIR /opt/ruby-prometheus-exporter-example

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN apk add --no-cache --virtual .bundledeps build-base && \
	bundle install --jobs=4 --retry=3 && \
	apk del --no-network .bundledeps

ADD config.ru config.ru

CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0:8080"]
