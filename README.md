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

#### Dependencies

As this is a phoenix project, Elixir dependencies are managed in `mix.exs` and JavaScript dependencies in `assets/package.json`.

If you find yourself updating these dependencies, be sure to update your docker images by running `make` or `make setup`.

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

## Tests

This project uses [ExCoveralls](https://github.com/parroty/excoveralls) for tracking test coverage. You can leverage the associated commands directly, but the Makefile has some useful abstractions:

- Run the tests and simple coverage output with `make tests`
- Generate Coveralls HTML and open in-browser with `make coverage`

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
- Deployment: https://hexdocs.pm/phoenix/deployment.html).
