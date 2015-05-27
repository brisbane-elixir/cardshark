defmodule CardShark.ProjectView do
  use CardShark.Web, :view

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id}
  end
end
