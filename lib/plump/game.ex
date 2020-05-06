defmodule Plump.Game do
  defstruct [:secret_key, status: :waiting, all_players: [], :current_player]
end
