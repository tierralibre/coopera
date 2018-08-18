defmodule Example.Mixfile do
  use Mix.Project

  def project do
    [app: :coopera,
     version: "0.0.1",
     elixir: "~> 1.5",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Coopera, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      # Note: we're using a local dependency here to keep this project in sync with the repo state.
      # In regular production you should use the latest published hex version.
      {:phoenix_gen_socket_client, "~> 2.1.1"},
      {:websocket_client, "~> 1.2"},
      {:exleveldb, "~> 0.12.2"},
      {:keccakf1600, "~> 2.0.0"},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:decimal, "~> 1.0"},
      {:strap, "~> 0.1.1"},
      {:sphincs, git: "https://github.com/ahf/sphincs.git"},
      {:jason, "~> 1.1"},
      {:merkle_tree, "~> 1.2.0"}
    ]
  end
end
