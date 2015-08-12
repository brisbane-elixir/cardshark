defmodule CardShark.ProjectView do
  use CardShark.Web, :view

  def render("index.json", %{projects: projects}) do
    %{projects: render_many(projects, CardShark.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    render_one(project, CardShark.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    %{id: project.id, name: project.name}
  end
end
