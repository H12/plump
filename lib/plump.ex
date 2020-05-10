defmodule Plump do
  @moduledoc """
  Plump keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Plump.Boundary.{GameManager, GameSession}

  def build_game(creator_name) do
    GameManager.build_game(creator_name)
  end

  def list_games do
    GameManager.list_games()
  end

  def add_player(code, player_name) do
    GameManager.add_player(code, player_name)
  end

  def start_game(code) do
    game = GameManager.lookup_game_by_code(code)
    GameSession.start_game(game)
  end
end
