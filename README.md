# Card Shark

## Run locally

```sh
mix deps.get
mix phoenix.server
```

Now you can visit [card_shark](localhost:4000).

## Deploy to heroku

```sh
heroku apps:create
heroku buildpack:set https://github.com/HashNuke/heroku-buildpack-elixir
git push heroku master
```
