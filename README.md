# OpenStates
[![Build Status](https://travis-ci.org/msimonborg/open_states.svg?branch=master)](https://travis-ci.org/msimonborg/open_states)
[![Coverage Status](https://coveralls.io/repos/github/msimonborg/open_states/badge.svg?branch=master)](https://coveralls.io/github/msimonborg/open_states?branch=master)
[![Hex pm](https://img.shields.io/hexpm/v/open_states.svg?style=flat)](https://hex.pm/packages/open_states)

An Elixir client for the OpenStates GraphQL API

## Installation

```elixir
def deps do
  [
    {:open_states, "~> 0.1.0"}
  ]
end
```

Configure your [OpenStates API key](https://openstates.org/api/register/) as an environment variable with the name `"OPENSTATES_API_KEY"`. Alternatively you can configure the key in your `config.exs` file:

```elixir
config :open_states, api_key: "xxxxxxxxxxxxxxxxx"
```

See [online documentation](https://hexdocs.pm/open_states) for usage and API reference.

# Contributing
Clone this repository and run the tests with `mix test` to make sure they pass. Make your changes, writing documentation and tests for all new functionality. Changes will not be merged without accompanying tests and docs. Run `mix open_states.build` to run the formatter, tests, linter, and generate Coveralls report and docs metrics. Development should be done with `Elixir version ~> 1.8` for proper formatter output, and the build task will raise an exception if using a version less than `1.8`. Now you're ready to submit a [pull request](https://help.github.com/en/articles/about-pull-requests)

# License
[MIT - Copyright (c) 2019 M. Simon Borg](LICENSE.txt)