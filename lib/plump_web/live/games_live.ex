defmodule PlumpWeb.GamesLive do
  use PlumpWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, creator: "", games: Plump.list_games())}
  end

  @impl true
  def handle_event("build", %{"creator" => creator}, socket) do
    Plump.build_game(creator)
    games = Plump.list_games()

    {:noreply, assign(socket, games: games, creator: "")}
  end
end
