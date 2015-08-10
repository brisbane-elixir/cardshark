defmodule CardShark.UserView do
  use CardShark.Web, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, CardShark.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    render_one(user, CardShark.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email}
  end
end
