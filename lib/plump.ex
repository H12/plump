defmodule Plump do
  @moduledoc """
  The Plump API, the entrypoint for creating, updating, and destroying games of Plump.
  """
  alias Plump.Boundary.{GameManager, GameSession}
  alias Plump.Core.Game

  @doc """
  Given a String representing the name of a game's creator, will build a game struct and use the
  provided name to populate the `creator` field with a corresponding Player struct.

  ## Examples

      iex> %Plump.Core.Game{creator: creator} = Plump.build_game("Hank")
      iex> creator == %Plump.Core.Player{name: "Hank"}
      true
  """
  def build_game(creator_name) do
    GameManager.build_game(creator_name)
  end

  @doc """
  A function that lists all the games that have been built, regardless of whether they have been
  "started" and have a corresponding GameSession.
  """
  def list_games do
    GameManager.list_games()
  end

  @doc """
  Given a String representing an existing Game's `secret_code`, returns the corresponding Game.
  """
  def lookup_game_by_code(code) do
    GameManager.lookup_game_by_code(code)
  end

  @doc """
  Given a String representing an existing Game's `secret_code`, and another string representing a
  new player, adds a Player struct representing that player to the corresponding Game.
  """
  def add_player(code, player_name) do
    GameManager.add_player(code, player_name)
  end

  @doc """
  Given a String representing an existing Game's `secret_code`, attempts to spin up an active child
  process for the corresponding Game. If successful, returns the Registry entry for that child
  process, and otherwise returns the error.
  """
  def start_game(code) do
    with %Game{} = game <- Plump.lookup_game_by_code(code),
         {:ok, _} <- GameSession.start_game(game) do
      registry_name_for_game(game)
    else
      error -> error
    end
  end

  @doc """
  Given the name of a registered game process, returns the "current player", or, the Player struct
  representing the player currently taking their turn.
  """
  def current_player(registry_name) do
    GameSession.current_player(registry_name)
  end

  @doc """
  Given the name of a registered game process, updates the `current_player` to be the next player,
  and returns the updated Game struct.
  """
  def take_turn(registry_name) do
    GameSession.take_turn(registry_name)
  end

  defp registry_name_for_game(game) do
    registry_name = {game.creator.name, game.secret_code}

    with {:via, _, _} = _ <- GameSession.via(registry_name) do
      registry_name
    else
      _error -> {:error, "`registry_name`'s shape is out of sync with &GameSession.via/1"}
    end
  end
end
