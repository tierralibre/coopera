defmodule Coopera do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(CooperaWeb.Endpoint, []),
      worker(Coopera.CooperatorSocketClient, []),
      #worker(Coopera.CertifiedCooperatorSocketClient, []),
      worker(Coopera.Server, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Coopera.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CooperaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
