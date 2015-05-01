defmodule CardShark.UserController do
  use CardShark.Web, :controller

  alias CardShark.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "users.json", users: users
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      Repo.insert(changeset)
    end

    render conn, "changeset.json", changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "user.json", user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)
    end

    render conn, "changeset.json", changeset: changeset
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)
    render conn, "user.json", user: user
  end
end
