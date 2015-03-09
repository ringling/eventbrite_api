defmodule EventbriteClient do

  def attendees(event_id, oauth_token) do
    url = attendees_url(event_id, oauth_token)
    {:ok, body} = get(url, [])
    body |> Poison.decode! |> Map.get("attendees") |> Enum.map fn(att)-> att |> Map.delete("event") end
  end

  defp attendees_url(event_id, oauth_token) do
    "#{System.get_env("EVENTBRITE_API_URL")}/#{event_id}/attendees/?token=#{oauth_token}"
  end

  def get(url, headers, timeout \\ 5000) do
    case HTTPotion.get(url, [headers: headers, timeout: timeout]) do
      %HTTPotion.Response{status_code: 200, body: body} ->
        {:ok, body}
      %HTTPotion.Response{status_code: 202, body: body} ->
        {:ok, body}
      %HTTPotion.Response{status_code: 201, body: body} ->
        {:ok, body}
      err_msg ->
        {:error, err_msg}
    end
  end

end
