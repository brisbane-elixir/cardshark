FROM trenpixster/elixir

RUN mkdir -p /var/www/app
COPY . /var/www/app

WORKDIR /var/www/app
RUN yes | mix local.hex
RUN mix deps.get

ENV PORT 2011
EXPOSE 2011

CMD ["elixir","-pa","_build/prod/consolidated","-S","mix","phoenix.server"]
