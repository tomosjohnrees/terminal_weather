defmodule PostCode do
  def to_longitude_latitude(postcode) do
    "http://api.postcodes.io/postcodes/" <> postcode
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> process_response_body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "The postcode API doesn't seem to be working"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process_response_body(body) do
    body
    |> Poison.decode! 
    |> extract_longitude_latitude
  end

  defp extract_longitude_latitude(response) do
    longitude = response |> longitude |> to_string
    latitude = response |> latitude |> to_string
    [ longitude: longitude, latitude: latitude ]
  end

  defp longitude(response) do
    response["result"]["longitude"]
  end

  defp latitude(response) do
    response["result"]["latitude"]
  end
end
