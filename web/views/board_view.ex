defmodule CardShark.BoardView do
  use CardShark.Web, :view

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, CardShark.BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, CardShark.BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id}
  end
end
