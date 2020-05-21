defmodule PlumpWeb.GamesLiveTest do
  use PlumpWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, games_live, disconnected_html} = live(conn, "/games")
    assert disconnected_html =~ "Wow... Look at all those Plump games!"
    assert render(games_live) =~ "Wow... Look at all those Plump games!"
  end
end
