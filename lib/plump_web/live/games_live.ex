defmodule PlumpWeb.GamesLive do
  use PlumpWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Plump.subscribe()
    {:ok, assign(socket, creator: "", games: Plump.list_games())}
  end

  @impl true
  def handle_event("build", %{"creator" => creator}, socket) do
    Plump.build_game(creator)
    games = Plump.list_games()

    {:noreply, assign(socket, games: games, creator: "")}
  end

  @impl true
  def handle_info({Plump, [:game, _event], _result}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, games: Plump.list_games())
  end
end
