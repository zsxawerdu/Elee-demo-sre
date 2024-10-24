defmodule Elee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Telemetry.Metrics

  @impl true
  def start(_type, _args) do
    children = [
      EleeWeb.Telemetry,
      Elee.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:elee, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:elee, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Elee.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Elee.Finch},
      # Start a worker by calling: Elee.Worker.start_link(arg)
      # NOTE
      {Peep, name: EleePeep, metrics: metrics()},
      {TelemetryMetricsPrometheus, [metrics: metrics()]},
      # {Elee.Worker, arg},
      # Start to serve requests, typically the last entry
      EleeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def metrics() do
    [
    sum("phoenix.endpoint.start.system_time",
      unit: {:native, :millisecond}
    ),
    sum("phoenix.endpoint.stop.duration",
      unit: {:native, :millisecond}
    ),


    sum("vm.memory.total", unit: {:byte, :kilobyte}),
    last_value("vm.total_run_queue_lengths.total"),
    last_value("vm.total_run_queue_lengths.cpu"),
    last_value("vm.total_run_queue_lengths.io")
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EleeWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
