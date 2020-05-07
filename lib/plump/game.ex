defmodule Plump.Game do
  alias Plump.Player

  defstruct status: :waiting,
            all_players: nil,
            creator: nil,
            current_player_id: nil,
            secret_code: nil

  def new(creator_name) do
    creator = Player.new(name: creator_name)

    %__MODULE__{
      all_players: %{0 => creator},
      creator: creator,
      current_player_id: 0,
      secret_code: generate_code(5)
    }
  end

  def is_code_valid(game, code) do
    game.secret_code == code
  end

  def add_player(game, player_name) do
    new_player = Player.new(name: player_name)
    put_in(game.all_players[map_size(game.all_players)], new_player)
  end

  def current_player(game) do
    game.all_players[game.current_player_id]
  end

  def next_player(game) do
    game.all_players[next_player_id(game)]
  end

  def next_player_id(game) do
    if game.current_player_id + 1 < map_size(game.all_players) do
      game.current_player_id + 1
    else
      0
    end
  end

  def advance_current_player(game) do
    put_in(game.current_player_id, next_player_id(game))
  end

  defp generate_code(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, length)
  end
end
