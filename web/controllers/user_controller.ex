defmodule CardShark.UserController do
  use CardShark.Web, :controller

  alias CardShark.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      user = Repo.insert(changeset)
      CardShark.Endpoint.broadcast! "stream", "userevent", %{event: "created", user: user}
      conn
      |> put_status(:created)
      |> json(user)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> json(changeset)
    end
  end

  def index(conn, _params) do
    json conn, Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    if user do
      json conn, user
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)

    if user do
      changeset = User.changeset(user, user_params)

      if changeset.valid? do
        updated_user = Repo.update(changeset)
        CardShark.Endpoint.broadcast! "stream", "userevent", %{event: "updated", user: updated_user}
        json conn, updated_user
      else
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    if user do
      json conn, Repo.delete(user)
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end
end
