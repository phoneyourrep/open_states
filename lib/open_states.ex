defmodule OpenStates do
  @moduledoc """
  Documentation for OpenStates.
  """

  @doc """
  Returns the API endpoint URL.

  ## Examples

      iex> OpenStates.url()
      "https://openstates.org/graphql"

  """
  @spec url :: String.t()
  def url, do: "https://openstates.org/graphql"

  @doc """
  Returns the API key.

  ## Examples

      iex> OpenStates.api_key()
      System.get_env("OPENSTATES_API_KEY")

  """
  @spec api_key() :: String.t()
  defdelegate api_key, to: OpenStates.Application

  @doc """
  Returns the API headers.

  ## Examples

      iex> OpenStates.headers()
      ["X-API-KEY": OpenStates.api_key()]

  """
  @spec headers() :: keyword
  def headers, do: ["X-API-KEY": api_key()]

  @doc """
  Constructs a GraphQL query to the OpenStates API.

  ## Example

      {:ok, response} =
        OpenStates.query(\"\"\"
        {jurisdictions {
          edges {
            node {
              id
            }
          }
        }}
        \"\"\")
      #=> {:ok, %Neuron.Response{body: %{ ... }, headers: [ ... ], status_code: 200}}

  """
  @spec query(query_string :: String.t()) ::
          {:ok, Neuron.Response.t()} | {:error, response :: term}
  def query(query_string) do
    Neuron.query(query_string, _variables = %{}, url: url(), headers: headers())
  end
end
