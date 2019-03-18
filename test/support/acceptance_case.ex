defmodule Canine.AcceptanceCase do
  @moduledoc """
  This module sets up the test case to be used by
  acceptance tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case
      use Hound.Helpers
      import CanineWeb.Router.Helpers
      import Canine.Constants

      @index_url page_url(CanineWeb.Endpoint, :index)
      @form_url page_url(CanineWeb.Endpoint, :form)
      @secret_url page_url(CanineWeb.Endpoint, :secret)

      # The default endpoint for testing
      @endpoint CanineWeb.Endpoint
    end
  end

  setup _tags do
    :ok
  end
end