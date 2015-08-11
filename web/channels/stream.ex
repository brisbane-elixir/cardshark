defmodule CardShark.StreamChannel do
  use Phoenix.Channel
  import Ecto.Query
  require Logger

  def join(topic, message, socket) do
    projects = CardShark.Repo.all CardShark.Project
    p = CardShark.ProjectView.render "index.json", projects: projects
    {:ok, p, socket}
  end
end
