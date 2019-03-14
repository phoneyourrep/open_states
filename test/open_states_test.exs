defmodule OpenStatesTest do
  use ExUnit.Case, async: true
  import Mock
  doctest OpenStates

  test "url/0 returns the endpoint url" do
    assert OpenStates.url() == "https://openstates.org/graphql"
  end

  test "api_key/0 returns the API key configured as an env variable" do
    assert OpenStates.api_key() == System.get_env("OPENSTATES_API_KEY")
  end

  test "headers/0 returns the API query headers" do
    assert OpenStates.headers() == ["X-API-KEY": OpenStates.api_key()]
  end

  test "query/1 sends an API query via Neuron.query/3" do
    with_mock Neuron, [query: fn(query_string, _, headers) -> {query_string, headers} end] do
      assert OpenStates.query("hello") == {"hello", [url: OpenStates.url, headers: OpenStates.headers()]}
    end
  end
end
