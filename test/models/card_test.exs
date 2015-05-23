defmodule CardShark.CardTest do
  use CardShark.ModelCase

  alias CardShark.Card

  @valid_attrs %{assignee: 42, detail: "some content", estimate: 42, summary: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
