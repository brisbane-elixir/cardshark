defmodule CardShark.ProjectController do
  use CardShark.Web, :controller

  alias CardShark.Project

  plug :scrub_params, "project" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    projects = Repo.all(Project)
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    changeset = Project.changeset(%Project{}, project_params)

    if changeset.valid? do
      project = Repo.insert(changeset)
      render(conn, "show.json", project: project)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Repo.get(Project, id)
    render conn, "show.json", project: project
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Repo.get(Project, id)
    changeset = Project.changeset(project, project_params)

    if changeset.valid? do
      project = Repo.update(changeset)
      render(conn, "show.json", project: project)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Repo.get(Project, id)

    project = Repo.delete(project)
    render(conn, "show.json", project: project)
  end
end
