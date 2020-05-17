defmodule PlumpWeb.GamesLiveTest do
  use PlumpWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, games_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Start a new Plump game!"
    assert render(games_live) =~ "Start a new Plump game!"
  end
end
