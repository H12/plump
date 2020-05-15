defmodule PlumpWeb.GamesLive do
  use PlumpWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", games: Plump.list_games())}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Games</h1>
    <ul>
      <%= for {_code, game} <- @games do %>
        <li><%= game.creator.name %></li>
      <% end %>
    </ul>
    """
  end
end
