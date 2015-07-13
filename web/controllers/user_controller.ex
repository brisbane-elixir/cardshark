defmodule CardShark.UserController do
  use CardShark.Web, :controller

  alias CardShark.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      user = Repo.insert!(changeset)
      CardShark.Endpoint.broadcast! "stream", "userevent", %{event: "created", user: user}
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render conn, "show.json", user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      user = Repo.update!(changeset)
      render(conn, "show.json", user: user)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    user = Repo.delete!(user)
    render(conn, "show.json", user: user)
  end
end
