defmodule Plump.Boundary.GameManager do
  alias Plump.Core.Game
  use GenServer

  def init(games) when is_map(games), do: {:ok, games}
  def init(_games), do: {:error, "games must be a Map"}

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, %{}, options)
  end

  def handle_call({:build_game, creator_name}, _from, games) do
    game = Game.new(creator_name)
    new_games = Map.put(games, game.secret_code, game)

    {:reply, game, new_games}
  end

  def handle_call({:lookup_game_by_code, code}, _from, games) do
    {:reply, games[code], games}
  end

  def handle_call({:list_games}, _from, games) do
    {:reply, games, games}
  end

  def handle_call({:add_player, code, player_name}, _from, games) do
    new_games =
      Map.update!(games, code, fn game ->
        Game.add_player(game, player_name)
      end)

    {:reply, :ok, new_games}
  end

  def handle_call({:remove_game, code}, _from, games) do
    new_games = Map.delete(games, code)
    {:reply, :ok, new_games}
  end

  def build_game(manager \\ __MODULE__, creator_name) do
    GenServer.call(manager, {:build_game, creator_name})
  end

  def lookup_game_by_code(manager \\ __MODULE__, code) do
    GenServer.call(manager, {:lookup_game_by_code, code})
  end

  def list_games(manager \\ __MODULE__) do
    GenServer.call(manager, {:list_games})
  end

  def add_player(manager \\ __MODULE__, code, player_name) do
    GenServer.call(manager, {:add_player, code, player_name})
  end

  def remove_game(manager \\ __MODULE__, code) do
    GenServer.call(manager, {:remove_game, code})
  end
end
