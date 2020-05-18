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
  def handle_info({Plump, [:game, :built], _code}, socket) do
    {:noreply, fetch_games(socket)}
  end

  @impl true
  def handle_info({Plump, [:game, :player_added], code}, socket) do
    {:noreply, fetch_game(socket, code)}
  end

  defp fetch_games(socket) do
    assign(socket, games: Plump.list_games())
  end

  defp fetch_game(socket, code) do
    game = Plump.lookup_game_by_code(code)

    # FIXME
    # This isn't being super smart about updating games -- it's still sending all the games
    # over the socket, even though only one has changed.
    assign(socket, games: Map.put(socket.assigns.games, code, game))
  end
end
