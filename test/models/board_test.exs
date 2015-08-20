defmodule CardShark.BoardTest do
  use CardShark.ModelCase

  alias CardShark.Board

  @valid_attrs %{columns: ["To do", "Doing", "Done"], name: "My Board", project_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Board.changeset(%Board{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Board.changeset(%Board{}, @invalid_attrs)
    refute changeset.valid?
  end
end
