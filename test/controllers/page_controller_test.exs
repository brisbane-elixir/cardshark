defmodule CardShark.PageControllerTest do
  use CardShark.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Cardshark"
  end
end
