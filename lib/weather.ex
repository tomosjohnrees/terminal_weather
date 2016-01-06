defmodule Weather do
  def process([longitude, latitude], api) do
    url(longitude, latitude, api)
    |> api_call(api)
  end

  defp url(longitude, latitude, api) do
    "http://api.openweathermap.org/data/2.5/" <>
    "#{ api |> to_string }" <>
    "?lat=" <> latitude <>
    "&lon=" <> longitude <>
    "&appid=2de143494c0b295cca9337e1e96b00e0"
  end

  defp api_call(url, api) do
    url
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> process_response_body(api)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "The #{api |> to_string }" <>
        "API doesn't seem to be working"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process_response_body(body, api) do
    body
    |> Poison.decode! 
    |> extract_data(api)
  end

  defp extract_data(response, "weather") do
    response["main"]
  end
  defp extract_data(response, "forecast") do
  end
end
