defmodule OpenStates.MixProject do
  use Mix.Project

  def project do
    [
      app: :open_states,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "OpenStates",
      source_url: "https://github.com/msimonborg/open_states",
      description: description()
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
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp package do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/msimonborg/open_states"}
    ]
  end

  defp description do
    "An Elixir client library for the OpenStates GraphQL API."
  end
end
