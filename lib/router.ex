defmodule EventbriteApi.Router do
  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  get "/" do
    {%{status: "OK"}, conn}
    |> encode_json
    |> set_cors_header
    |> send_response
  end

  get "/attendees/:event_id" do
    attendees = ConCache.get_or_store(:eventbrite_cache, :attendees, fn ->
      Logger.info "Cache for `attendees` stale. Fetching types."
      EventbriteClient.attendees(event_id, System.get_env("OAUTH_TOKEN")) |> Enum.map(fn(attendee)->
        %{
          profile: Map.get(attendee, "profile") |> Map.delete("addresses") |> Map.delete("email"),
          answers: Map.get(attendee, "answers")}
      end)
    end)

    {attendees, conn}
    |> encode_json
    |> set_cors_header
    |> send_response
  end


  defp encode_json({entity, conn}) do
    conn = conn |> put_resp_header("content-type", "application/json")
    {entity |> Poison.Encoder.encode([]), conn}
  end

  defp send_response({entity, conn}, status \\ 200) do
    conn |> send_resp(status, entity)
  end

  defp set_cors_header({entity, conn}) do
    conn = conn |> put_resp_header("Access-Control-Allow-Origin", "*")
    {entity, conn}
  end

end
