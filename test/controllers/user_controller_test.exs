defmodule CardShark.UserControllerTest do
  use CardShark.ConnCase

  alias CardShark.User
  @valid_params user: %{email: "some content", password: "some content"}
  @invalid_params user: %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "GET /users", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "GET /users/new", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "POST /users with valid data", %{conn: conn} do
    conn = post conn, user_path(conn, :create), @valid_params
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "POST /users with invalid data", %{conn: conn} do
    conn = post conn, user_path(conn, :create), @invalid_params
    assert html_response(conn, 200) =~ "New user"
  end

  test "GET /users/:id", %{conn: conn} do
    user = Repo.insert %User{}
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "Show user"
  end

  test "GET /users/:id/edit", %{conn: conn} do
    user = Repo.insert %User{}
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "PUT /users/:id with valid data", %{conn: conn} do
    user = Repo.insert %User{}
    conn = put conn, user_path(conn, :update, user), @valid_params
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "PUT /users/:id with invalid data", %{conn: conn} do
    user = Repo.insert %User{}
    conn = put conn, user_path(conn, :update, user), @invalid_params
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "DELETE /users/:id", %{conn: conn} do
    user = Repo.insert %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
