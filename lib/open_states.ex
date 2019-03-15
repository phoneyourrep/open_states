defmodule OpenStates do
  @moduledoc """
  An Elixir client for the OpenStates GraphQL API.
  """

  @type response :: {:ok, Neuron.Response.t()} | {:error, response :: term}
  @type args :: [atom | String.t()]

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
  Returns the request headers.

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
        {
          jurisdictions {
            edges {
              node {
                id
              }
            }
          }
        }
        \"\"\")
      #=> {:ok, %Neuron.Response{body: %{ ... }, headers: [ ... ], status_code: 200}}

  """
  @spec query(query_string :: String.t()) :: response
  def query(query_string, opts) do
    opts = Keyword.merge(opts, [url: url(), headers: headers()])
    Neuron.query(query_string, _variables = %{}, opts)
  end

  @doc """
  Calls `query/1` passing the string as the argument.

  ## Example

      ~q\"\"\"
      {
        jurisdictions {
          edges {
            node {
              id
            }
          }
        }
      }
      \"\"\"
      #=> {:ok, %Neuron.Response{body: %{ ... }, headers: [ ... ], status_code: 200}}
  """
  @spec sigil_q(query_string :: String.t(), list) :: response
  def sigil_q(query_string, []), do: query(query_string)

  @doc """
  Fetches the jurisdiction objects from the API.
  """
  @spec jurisdictions() :: response
  def jurisdictions, do: jurisdictions(attrs: [:id, :name])

  @spec jurisdictions(attrs: args) :: response
  def jurisdictions(attrs: attrs) do
    attrs = Enum.join(attrs, "\n")

    ~q"""
    {
      jurisdictions {
        edges {
          node {
            #{attrs}
          }
        }
      }
    }
    """
  end

  @doc """
  Fetches legislators from a particular jurisdiction and organization.
  """
  def people_from(opts) do
    name = Keyword.get(opts, :name)
    id = Keyword.get(opts, :id)
    classification = Keyword.get(opts, :classification)
    attrs = Keyword.get(opts, :attrs)

    ~q"""
    {
      jurisdiction(name: "#{name}", id: "#{id}") {
        name
        organizations(first: 1, classification: "#{classification}") {
          edges {
            node {
              name
              currentMemberships {
                person {
                  #{Enum.join(attrs, "\n")}
                }
              }
            }
          }
        }
      }
    }
    """
  end
end
