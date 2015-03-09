defmodule EventbriteApiTest do
  use ExUnit.Case

  @event_api 15975719808

  test "the truth" do
    assert 1 + 1 == 2
    IO.inspect EventbriteClient.attendees(@event_api, System.get_env("OAUTH_TOKEN"))
  end

end
