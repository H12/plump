defmodule PlumpWeb.PlumpLive do
  use PlumpWeb, :live_view

  def render(assigns) do
    ~L"""
    <section>
      <h1><%= gettext "Start a new %{name} game, or join an existing one?", name: "Plump" %></h1>
      <ul>
        <li><%= link "Create", to: "/create" %></li>
        <li><%= link "Join", to: "/join" %></li>
      </ul>
    </section>
    """
  end
end
