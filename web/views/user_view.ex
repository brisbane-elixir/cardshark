defmodule CardShark.UserView do
  use CardShark.Web, :view

  def render("users.json", %{users: users}) do
    users
  end

  def render("user.json", %{user: user}) do
    user
  end

  def render("changeset.json", %{changeset: changeset}) do
    changeset
  end
end
