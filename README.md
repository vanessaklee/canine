# Canine

Canine is a simple series of webpages used to demonstrate the howling success of the Hound testing tool.

## Bone Simple Set-up

Create a simple Phoenix called Canine.

```
> mix phx.new canine --no-ecto
```

Add Hound as a dependency in `mix.exs`.

```
{:hound, "~> 1.0"}
```

Hound requires a webdriver for browser automation. We will use selenium. Install and run:

```
> brew install selenium-server-standalone
> selenium-server
```

Start Hound in `test/test_helpers.exs`. Add this above `ExUnit.start()`

```
Application.ensure_all_started(:hound)
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

. . . and set `server` to true: 

```
config :canine, CanineWeb.Endpoint,
  http: [port: 4001],
  server: true
```

Start your Phoenix server

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with a REGION value from the list ["northeast", "midwest", "south", "west"]
    * Elixir: `REGION=midwest mix phx.server`
    * Interactive elixir: `REGION=midwest iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Hound can be used as a part of ExUnit tests and run with `mix test`.

## Lab-ra-cadabra!

The acceptance tests live in `test/canine_web/acceptance/` and use `test/support/acceptance_case.exs`, an `ExUnit.CaseTemplate`.

The simplest test is `welcome_test.exs`. It demonstrates these Hound.Helpers:
  
  * [navigate_to/2][navigate_to]
    * navigates to a url or relative path
  * [find_element/3][find_element] 
    * accepts a strategy, selector, and optional retries value
  * [visible_text/1][visible_text]
    * gets the visible text of an element
  * [page_title/0][page_title]
    * gets the title of the current page

The more complex test inputs form data and metadata: `region_test.exs`. It demonstrates:

  * multiple browser sessions
  * the `:xpath` strategy 
  * [click/1][click]
    * clicks on an element
  * [current_url/0][current_url]
    * gets url of the current page

The advanced test is `form_test.exs`. It demonstrates:
  
  * uses [execute_script/2][execute_script] to select value from a select list
    * executes javascripts 
  * [fill_field/2][fill_field]
    * sets a field's value
  * uses [change_session_to/2][change_session_to] to use multiple browser sessions for permutations
  * [take_screenshot/1][take_screenshot]
    * takes a screenshot of the current page
  * slow down tests with `:timer.sleep()`

[navigate_to]: https://hexdocs.pm/hound/Hound.Helpers.Navigation.html#navigate_to/2
[find_element]: https://hexdocs.pm/hound/Hound.Helpers.Page.html#find_element/3
[visible_text]: https://hexdocs.pm/hound/Hound.Helpers.Element.html#visible_text/1
[page_title]: https://hexdocs.pm/hound/Hound.Helpers.Page.html#page_title/0
[click]: https://hexdocs.pm/hound/Hound.Helpers.Element.html#click/1
[current_url]: https://hexdocs.pm/hound/Hound.Helpers.Navigation.html#current_url/0
[execute_script]: https://hexdocs.pm/hound/Hound.Helpers.ScriptExecution.html#execute_script/2
[fill_field]: https://hexdocs.pm/hound/Hound.Helpers.Element.html#fill_field/2
[change_session_to]: https://hexdocs.pm/hound/Hound.Helpers.Session.html#change_session_to/2
[take_screenshot]: https://hexdocs.pm/hound/Hound.Helpers.Screenshot.html#take_screenshot/1

### Show off: Metadata

Canine uses a Plug called `Regionalize` for set regional vernacular. If this were a real app, this value would be part of an authentication process, but since this is a demo app for testing purposes, we aren't going to worry about the prod environment. We will use `Application.get_env("REGION")`.

**MIX_ENV=dev**: In the dev environment, `Application.get_env("REGION")` is from an entry in `config/dev.exs` that uses `System.get_evn("REGION")` to grab the "REGION" value from the shell. If a "REGION" is not found, the user is sent to a non-functional signup page.

**MIX_ENV=test**: In the test environment, `Application.get_env("REGION")` is from Hound's metadata. Metadata parameters are set like this:

```
Hound.start_session(metadata: %{region: "northeast"})
```

If the metadata is not found, the test session will fail and alert you with an error.

`** (RuntimeError) could not find a session for process #PID<X.XXX.X>`


## Best in Show

Structure of pertitent files.

```
- test/
  - canine_web/
    - acceptance/
      - form_test.exs
      - region_test.exs
      - welcome_test.exs
  - support/
    - acceptance_case.ex
  - test_helper.exs
```


## Go Fetch!

  * Hound [Helpers][helpers], in particular 
    * Hound [Navigation][nav] Helpers
    * Hound [Element][el] Helpers
    * Hound [Javascript Execution][je] Helpers
    * Hound [Screenshot][ss] Helpers
  * Configuring Hound: https://github.com/HashNuke/hound/blob/master/notes/configuring-hound.md
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