defmodule PlumpWeb.JoinLive do
  use PlumpWeb, :live_view

  @impl true
  def mount(%{"code" => code}, _session, socket) do
    {:ok, assign(socket, code: code, player: "")}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, code: nil, player: "")}
  end

  @impl true
  def handle_event("join", %{"code" => code, "player" => player}, socket) do
    {:ok, code} = Plump.add_player(code, player)

    {:noreply, assign(socket, code: code, player: player)}
  end
end
