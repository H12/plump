defmodule PlumpWeb.CreateLive do
  use PlumpWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, code: nil, creator: "")}
  end

  @impl true
  def handle_event("create", %{"creator" => creator}, socket) do
    {:ok, code} = Plump.build_game(creator)

    {:noreply, assign(socket, code: code, creator: creator)}
  end
end
