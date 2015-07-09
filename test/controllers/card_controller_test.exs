defmodule CardShark.CardControllerTest do
  use CardShark.ConnCase

  alias CardShark.Card
  @valid_attrs %{assignee: 42, detail: "some content", estimate: 42, summary: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, card_path(conn, :index)
    assert json_response(conn, 200)["cards"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = get conn, card_path(conn, :show, card)
    assert json_response(conn, 200) == %{
      "id" => card.id,
      "summary" => card.summary,
      "detail" => card.detail,
      "estimate" => card.estimate,
      "assignee" => card.assignee
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, card_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = put conn, card_path(conn, :update, card), card: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = put conn, card_path(conn, :update, card), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = delete conn, card_path(conn, :delete, card)
    assert json_response(conn, 200)["id"]
    refute Repo.get(Card, card.id)
  end
end
