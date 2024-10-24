# SRE Challenge Notes

Check following places

source code locations to check

- lib/elee/application.ex : 23-44 , 36-51
- mix.exs : 62-64

# General Elixir / Phoenix.

- I spent last week getting handle on how live view works etc to do this

Examine lib/elee_web/live/food_live/index.ex for using the CSV file as data
Check router.ex for mapping, I did use phx.gen to generate the live view.

# Testing Prometheus, no export is set, but getting data to export is available.

````shell
iex -S mix

EleePeep |> Peep.get_all_metrics() |> Peep.Prometheus.export()```
````

# Elee

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
