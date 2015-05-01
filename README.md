# Card Shark

## Run locally

Install dependencies

```sh
mix deps.get
```

Create database

```sh
mix ecto.create
```

Run database migrations

```sh
mix ecto.migrate
```

Start server in foreground

```sh
mix phoenix.server
```

Now you can visit [card_shark](http://localhost:4000).

## Interactive console

```sh
iex -S mix phoenix.server
```

You can execute database actions:

```
alias CardShark.Repo
alias CardShark.User

users = Repo.all User

changeset = User.changeset(%User{}, %{:email => "me@mail.com", :password => "1"})
changeset.valid?
user = Repo.insert changeset

changeset = User.changeset(user, %{:password => "2"})
changeset.valid?
user = Repo.update changeset

user = Repo.get User, 1
Map.get user, :email
Map.get user, :inserted_at
```

## Deploy to heroku

```sh
heroku apps:create $NAME
heroku buildpack:set https://github.com/HashNuke/heroku-buildpack-elixir
git push heroku master
heroku config:add DATABASE_USERNAME=$USER DATABASE_PASSWORD=$PASSWORD DATABASE_DATABASE=$DATABASE DATABASE_HOSTNAME=$HOSTNAME
heroku run mix ecto.migrate
```

You can get the values for the required DATABASE environment variables by splitting the heroku generated DATABASE_URL:

```sh
heroku config

DATABASE_URL=postgres://$USER:$PASSWORD@$HOSTNAME:5432/$DATABASE
```

Now you can visit `http//$NAME.herokuapp.com`.

# API

## Users

### List users

```sh
curl $CARD_SHARK_URL/api/users
```

### Show user

```sh
curl $CARD_SHARK_URL/api/users/1
```

### Create user

```sh
curl $CARD_SHARK_URL/api/users \
  -H 'Content-Type: application/json' \
  -X POST \
  -d @/dev/stdin <<JSON
{
  "user": {
    "email": "hgadmin2@example.com",
    "password": "1"
  }
}
JSON
```

### Update user

```sh
curl $CARD_SHARK_URL/api/users/1 \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d @/dev/stdin <<JSON
{
  "user": {
    "password": "2"
  }
}
JSON
```

### Delete user

```sh
curl $CARD_SHARK_URL/api/users/1 -X DELETE
```
