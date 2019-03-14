defmodule OpenStates.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/msimonborg/open_states"

  def project do
    [
      app: :open_states,
      version: @version,
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "OpenStates",
      description: description(),
      docs: [
        source_ref: "v#{@version}",
        main: "OpenStates",
        source_url: @repo_url
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test,
        "coveralls.safe_travis": :test,
        "open_states.build": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {OpenStates.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:neuron, "~> 1.1.0"},
      {:receiver, "~> 0.2.1"},
      {:stream_data, "~> 0.4.2", only: :test},
      {:mock, "~> 0.3.0", only: :test},
      {:ex_doc, "~> 0.19.3", only: [:dev, :test]},
      {:excoveralls, "~> 0.10", only: :test},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, "~> 2.0", only: [:dev, :test]}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url},
      maintainers: ["Matt Borg"]
    ]
  end

  defp description do
    "An Elixir client library for the OpenStates GraphQL API."
  end
end
