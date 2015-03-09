defmodule EventbriteClientTest do
  use ExUnit.Case, async: false
  import Mock

  @event_id "1234567890"
  @oauth_token "TOKEN"

  test_with_mock "perform GET request", HTTPotion, [], mocks do
    System.put_env("EVENTBRITE_API_URL", "EVENTBRITE_API_URL")
    url = "EVENTBRITE_API_URL/#{@event_id}/attendees/?token=#{@oauth_token}"
    EventbriteClient.attendees(@event_id, @oauth_token)
    assert called HTTPotion.get(url, [headers: [], timeout: 5000])
  end

  defp mocks do
    [get: fn(_url, _options) -> attendee_response end]
  end

  defp attendee_response do
    %HTTPotion.Response{
      body: "{\"attendees\":[]}",
      headers: [],
      status_code: 200
    }
  end

end
