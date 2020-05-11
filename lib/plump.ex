defmodule Plump do
  @moduledoc """
  Plump keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Plump.Boundary.{GameManager, GameSession}
  alias Plump.Core.Game

  def build_game(creator_name) do
    GameManager.build_game(creator_name)
  end

  def list_games do
    GameManager.list_games()
  end

  def lookup_game_by_code(code) do
    GameManager.lookup_game_by_code(code)
  end

  def add_player(code, player_name) do
    GameManager.add_player(code, player_name)
  end

  def start_game(code) do
    with %Game{} = game <- Plump.lookup_game_by_code(code),
         {:ok, _} <- GameSession.start_game(game) do
      registry_name_for_game(game)
    else
      error -> error
    end
  end

  def current_player(registry_name) do
    GameSession.current_player(registry_name)
  end

  def take_turn(registry_name) do
    GameSession.take_turn(registry_name)
  end

  defp registry_name_for_game(game) do
    registry_name = {game.creator.name, game.secret_code}

    with {:via, _, _} = _ <- GameSession.via(registry_name) do
      registry_name
    else
      _error -> {:error, "registry_name shape is out of sync with &GameSession.via/1"}
    end
  end
end
