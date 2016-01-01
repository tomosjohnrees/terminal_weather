defmodule Weather do
  def current_weather([longitude: longitude, latitude: latitude]) do
    "http://api.openweathermap.org/data/2.5/weather?" <>
    "lat=" <> latitude <>
    "&lon=" <> longitude <>
    "&appid=2de143494c0b295cca9337e1e96b00e0"
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> process_response_body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "The forecast API doesn't seem to be working"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process_response_body(body) do
    body
    |> Poison.decode! 
    |> extract_main_data
  end

  defp extract_main_data(response) do
    response["main"]
  end
end
