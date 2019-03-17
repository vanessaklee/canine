# Canine

Canine is a simple series of webpages used to demonstrate the howling success of the Hound testing tool.

## Puppy Steps

First we create a simple Phoenix called Canine.

```
> mix phx.new canine --no-ecto
```

Then add Hound as a dependency in `mix.exs`.

```
{:hound, "~> 1.0", only: :test}
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


In `config/test.exs` add:

```
config :hound, browser: "chrome"
```

And in the same file, set `server` to true: 

```
config :canine, CanineWeb.Endpoint,
  http: [port: 4001],
  server: true
```

Hound can be used as a part of ExUnit tests:

```
> mix test
```

## Go get 'em!

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Puppy School

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
