defmodule OpenStates.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  use Receiver, as: :credentials

  def start(_type, _args) do
    api_key = Application.get_env(:open_states, :api_key, System.get_env("OPENSTATES_API_KEY"))
    start_credentials(fn -> api_key end)

    children = []

    opts = [strategy: :one_for_one, name: OpenStates.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec api_key() :: String.t()
  def api_key, do: get_credentials()
end
