FROM trenpixster/elixir

RUN echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" >> /etc/apt/sources.list && \
    apt-key adv --fetch-keys http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc && \
    apt-get -qq update && \
    apt-get install -y postgresql-client

RUN yes | mix local.hex

RUN mkdir -p /var/www/app
COPY . /var/www/app

WORKDIR /var/www/app
RUN mix deps.get

ENV PORT 2011
EXPOSE 2011

CMD ["elixir","-pa","_build/prod/consolidated","-S","mix","phoenix.server"]
