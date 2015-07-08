defmodule CardShark.PageController do
  use CardShark.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
