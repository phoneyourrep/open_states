defmodule OpenStatesTest do
  use ExUnit.Case, async: false
  import Mock
  doctest OpenStates

  test "url/0 returns the endpoint url" do
    assert OpenStates.url() == "https://openstates.org/graphql"
  end

  test "api_key/0 returns the API key configured as an env variable" do
    assert OpenStates.api_key() == System.get_env("OPENSTATES_API_KEY")
  end

  test "api_key/0 can be overriden in Application config" do
    original = OpenStates.api_key()
    Application.put_env(:open_states, :api_key, "hello")
    :ok = OpenStates.Application.set_api_key_from_env()

    assert OpenStates.api_key() == "hello"

    Application.put_env(:open_states, :api_key, original)
    :ok = OpenStates.Application.set_api_key_from_env()

    assert OpenStates.api_key() == original
  end

  test "headers/0 returns the API query headers" do
    assert OpenStates.headers() == ["X-API-KEY": OpenStates.api_key()]
  end

  test "query/1 sends an API query via Neuron.query/3" do
    with_mock Neuron, query: fn query_string, _, headers -> {query_string, headers} end do
      assert OpenStates.query("hello") ==
               {"hello", [url: OpenStates.url(), headers: OpenStates.headers(), timeout: 8000]}
    end
  end

  test "sigil_q/2 sends an API query via Neuron.query/3" do
    with_mock Neuron, query: fn query_string, _, headers -> {query_string, headers} end do
      import OpenStates, only: [sigil_q: 2]

      assert ~q"hello" ==
               {"hello", [url: OpenStates.url(), headers: OpenStates.headers(), timeout: 8000]}
    end
  end
end
