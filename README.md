# Card Shark
[![Build Status](https://semaphoreci.com/api/v1/projects/d1338bad-4a9d-40f7-bced-2bebf6bf6088/483360/badge.svg)](https://semaphoreci.com/colinbankier/cardshark)


[![Join the chat at https://gitter.im/brisbane-elixir/cardshark](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/brisbane-elixir/cardshark?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Run locally

Install dependencies

```sh
mix deps.get
```

Set Database URL
```sh
export DATABASE_URL="postgres://$(whoami):@localhost/card_shark_dev"
```

Create database

```sh
mix ecto.create
```

Run database migrations

```sh
mix ecto.migrate
```

Install node dependencies

```sh
npm install
bower install
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

```elixir
alias CardShark.Repo
alias CardShark.User
alias CardShark.Card
alias CardShark.Project

import Ecto.Query
import Ecto.Model

users = Repo.all User

changeset = User.changeset(%User{}, %{:email => "me@mail.com", :password => "1"})
changeset.valid?
{:ok,user} = Repo.insert changeset

changeset = User.changeset(user, %{:password => "2"})
changeset.valid?
user = Repo.update! changeset

user = Repo.get User, 1
user.email
user.inserted_at

changeset = Project.changeset(%Project{}, %{name: "card shark"})
{:ok,project} = Repo.insert changeset

changeset = Card.changeset(
  %Card{project_id: project.id},
  %{
    summary: "create association",
    detail: "cards should be linked to project",
    estimate: 3,
    assignee: 1
  }
)
changeset.valid?
{:ok, card} = Repo.insert changeset

card = Repo.get Card, card.id
changeset = Card.changeset(
  card,
  %{
    summary: "really create association"
  }
)
changeset.valid?
card = Repo.update changeset

[project|_] = Repo.all Project

query = from c in Card,
      where: c.id == ^card.id,
     select: c,
    preload: :project
[card] = Repo.all query

card = Repo.get Card, card.id
query = assoc(card, :project)
[project] = Repo.all query
query = assoc(project, :cards)
cards = Repo.all query

CardShark.Endpoint.broadcast! "stream", "userevent", %{
  event: "created",
  user: %{
    username: "mark",
    content: "content"
  }
}

CardShark.Endpoint.broadcast! "stream", "cardevent", %{
  event: "created",
  card: %{
    summary: "manage cards",
    detail: "crud operations for managing cards",
    estimate: "1",
    assignee: "mark"
  }
}
```

## Run in docker container

Install docker and docker compose.

```sh
fig build
fig up
fig run api mix ecto.create
fig run api mix ecto.migrate
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

```
export CARD_SHARK_URL=http://127.0.0.1:4000
```

## Projects

### Create project

```sh
curl $CARD_SHARK_URL/api/projects \
  -H 'Content-Type: application/json' \
  -X POST \
  -d @/dev/stdin <<JSON
{
  "project": {
    "name": "world domination"
  }
}
JSON
```

## Cards

### Create card

```sh
curl $CARD_SHARK_URL/api/cards \
  -H 'Content-Type: application/json' \
  -X POST \
  -d @/dev/stdin <<JSON
{
  "card": {
    "summary": "manage cards",
    "detail": "crud operations for managing cards",
    "estimate": "1",
    "assignee": "1",
    "priority": "30.0",
    "status": "todo"
  }
}
JSON
```

### List cards

```sh
curl $CARD_SHARK_URL/api/cards

http $CARD_SHARK_URL/api/cards
```

### Show card

```sh
curl $CARD_SHARK_URL/api/cards/1

http $CARD_SHARK_URL/api/cards/1
```

### Update card

```sh
curl $CARD_SHARK_URL/api/cards/1 \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d @/dev/stdin <<JSON
{
  "card": {
    "summary": "create, read, update, and delete cards"
  }
}
JSON
```

### Delete card

```sh
curl $CARD_SHARK_URL/api/cards/1 -X DELETE
```

## Users

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

### List users

```sh
curl $CARD_SHARK_URL/api/users
```

### Show user

```sh
curl $CARD_SHARK_URL/api/users/1
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
