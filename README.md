# Plump

This is a simple, real-time Plump game built with Phoenix LiveView and OTP.

## Getting Started

Below are the setup steps for local development. You can choose whether you'd like to run the app containerized with Docker, or natively on your local machine.

### With Docker

You can use `docker-compose` commands directly, but this project has a Makefile for your convenience.

#### Requirements

- `docker`
- `docker-compose`

#### Commands

- Setup the project with `make` or `make setup`
- Start Phoenix endpoint with `make start`
- Stop Phoenix endpoint with `make stop`

### Natively

Choose your preferred method of installation. This project's creator likes [`asdf`](https://asdf-vm.com/#/).

#### Requirements

- Elixir `1.10.x`
- Erlang `22.2.x`

#### Commands

- Setup the project with `mix setup`
- Start Phoenix endpoint with `mix phx.server`

### Hooray!

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
- Deployment: https://hexdocs.pm/phoenix/deployment.html).
