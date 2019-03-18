# Canine

Canine is a simple series of webpages used to demonstrate the howling success of the Hound testing tool.

## Puppy Steps

First we create a simple Phoenix called Canine.

```
> mix phx.new canine --no-ecto
```

Then add Hound as a dependency in `mix.exs`.

```
{:hound, "~> 1.0"}
```

Hound requires a webdriver for browser automation. For this app we will use selenium. Install and run:

```
> brew install selenium-server-standalone
> selenium-server
```

Hound requires a few additions to the code. In `test/test_helpers.exs` replace:

```
ExUnit.start()
```

with 


```
Application.ensure_all_started(:hound)
ExUnit.start()
```

In `config/dev.exs` add:

```
config :canine, region: System.get_env("REGION")
```

In `config/test.exs` add:

```
config :hound, browser: "chrome"
config :canine, region: System.get_env("REGION")
```

In the same file, set `server` to true: 

```
config :canine, CanineWeb.Endpoint,
  http: [port: 4001],
  server: true
```

Hound can be used as a part of ExUnit tests and can be run with `mix test`.

## Sic 'em!

Canine uses a Plug called `Regionalize` for set regional vernacular. If this were a real app, this value would be part of an authentication process, but since this is a demo app for testing purposes, we will use `Application.get_env("REGION")`.

**MIX_ENV=dev**: In the dev environment, `Application.get_env("REGION")` is from an entry in `config/dev.exs` that uses `System.get_evn("REGION")` to grab the "REGION" value from the shell. If a "REGION" is not found, the user is sent to a non-functional signup page.

**MIX_ENV=test**: In the test environment, `Application.get_env("REGION")` is from Hound's metadata. Metadata parameters are set like this:

```
Hound.start_session(metadata: %{region: "northeast"})
```

If the metadata is not found, the test session will fail and alert you with an error.

`** (RuntimeError) could not find a session for process #PID<X.XXX.X>`

### Start your Phoenix server

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with a REGION value from the list ["northeast", "midwest", "south", "west"]
    * Elixir: `REGION=midwest mix phx.server`
    * Interactive elixir: `REGION=midwest iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Hound can be used as a part of ExUnit tests and can be run with `mix test`.

## Dig Deep

Let's take a walk through the test design and set up. First, here is the structure of the test files pertinent to this talk:

```
- test/
  - canine_web/
    - acceptance/
      - form_test.exs
      - region_test.exs
      - welcome_test.exs
    - controllers/
      - page_controller_test.exs
  - support/
    - acceptance_case.ex
  - test_helper.exs
```

Housekeeping

  * Controller tests will fail without the Region `test/controllers/page_controller_test.exx`
  * Canine.AcceptanceCase uses `ExUnit.CaseTemplate`; see `support/acceptance_case.exs`

Presentation Order

  * welcome_test.exs
  * region_test.exs
    * Note multiple browser sessions at work to cover all possible Regions
    * Note regex selector for Hound Element Helper
  * form_test.exs
    * Note multiple browser sessions at work to cover combinations
    * Note javascript execution
    * Note the screenshot

## Go Fetch!

  * Hound [Helpers][helpers], in particular 
    * Hound [Navigation][nav] Helpers
    * Hound [Element][el] Helpers
    * Hound [Javascript Execution][je] Helpers
    * Hound [Screenshot][ss] Helpers
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

[helpers]: https://hexdocs.pm/hound/readme.html#helpers
[nav]: http://hexdocs.pm/hound/Hound.Helpers.Navigation.html
[el]: http://hexdocs.pm/hound/Hound.Helpers.Element.html
[je]: http://hexdocs.pm/hound/Hound.Helpers.ScriptExecution.html
[ss]: http://hexdocs.pm/hound/Hound.Helpers.Screenshot.html