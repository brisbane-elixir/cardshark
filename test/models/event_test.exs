defmodule CardShark.EventTest do
  use CardShark.ModelCase

  alias CardShark.Event

  @valid_attrs %{
    name: "some content",
    payload: %{some_key: "a value"},
    timestamp: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
