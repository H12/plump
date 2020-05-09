defmodule Plump.Boundary.GameSession do
  alias Plump.Core.Game
  use GenServer

  def child_spec(game) do
    %{
      id: {__MODULE__, {game.creator.name, game.secret_code}},
      start: {__MODULE__, :start_link, [game]}
    }
  end

  def init(game) do
    {:ok, game}
  end

  def start_link(game) do
    GenServer.start_link(
      __MODULE__,
      game,
      name: via({game.creator.name, game.secret_code})
    )
  end

  def via({_creator_name, _secret_code} = name) do
    {
      :via,
      Registry,
      {Plump.Registry.GameSession, name}
    }
  end

  def start_game(game) do
    DynamicSupervisor.start_child(
      Plump.Supervisor.GameSession,
      {__MODULE__, game}
    )
  end

  def handle_call(:current_player, _from, game) do
    {:reply, Game.current_player(game), game}
  end

  def active_sessions do
    Plump.Supervisor.GameSession
    |> DynamicSupervisor.which_children()
    |> Enum.filter(&child_pid?/1)
    |> Enum.flat_map(&active_sessions/1)
  end

  defp child_pid?({:undefined, pid, :worker, [__MODULE__]}) when is_pid(pid), do: true
  defp child_pid?(_child), do: false

  defp active_sessions({:undefined, pid, :worker, [__MODULE__]}) do
    Plump.Registry.GameSession
    |> Registry.keys(pid)
  end
end
