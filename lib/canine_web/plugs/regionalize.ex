defmodule CanineWeb.Plug.Regionalize do
    @moduledoc """
    Plug for determining what region the user is from in order to display regional vernacular. If this were a real app, this value would be part of an authentication process.

    Since this is merely a demo app, we will use `Application.get_env("REGION")`.

    ### MIX_ENV=dev

    In the dev environment, `Application.get_env("REGION")` is from an entry in `config/dev.exs` that uses `System.get_evn("REGION")` to grab the "REGION" value from the shell. If a "REGION" is not found, the user is sent to a message page.

    ### MIX_ENV=test

    In the test environment, `Application.get_env("REGION")` is from Hound's metadata. Metadata parameters are set like this:

    ```
    Hound.start_session(metadata: %{region: "northeast"})
    ```

    If the metadata is not found, the test session will fail and alert you with an error.

    `** (RuntimeError) could not find a session for process #PID<X.XXX.X>`

    ## Accepted Regions

    - northeast
    - midwest
    - south
    - west
    """
    import Canine.Constants
    alias CanineWeb.PageView

    @regions regions()

    def regionalize(conn, _opts) do
        region = case Mix.env do
            :test -> 
                ua = conn 
                    |> Plug.Conn.get_req_header("user-agent") 
                    |> List.first
                if is_nil(ua), do: nil, else: Hound.Metadata.extract(ua) |> Map.get(:region)
            _ -> Application.get_env(:canine, :region) 
        end
        case region do
            r when r in @regions -> 
                conn 
                |> Plug.Conn.assign(:region, region)
            _ -> 
                signup(conn)
        end
    end

    def signup(conn) do
        conn
        |> Plug.Conn.put_status(200)
        |> Phoenix.Controller.render(PageView, :signup) 
        |> Plug.Conn.halt()
    end

end