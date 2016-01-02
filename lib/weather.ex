defmodule Weather do
  def weather([longitude: longitude, latitude: latitude]) do
    "http://api.openweathermap.org/data/2.5/weather?" <>
    "lat=" <> latitude <>
    "&lon=" <> longitude <>
    "&appid=2de143494c0b295cca9337e1e96b00e0"
    |> api_call(:weather)
  end

  def forecast([longitude: longitude, latitude: latitude]) do
    "http://api.openweathermap.org/data/2.5/forecast?" <>
    "lat=" <> latitude <>
    "&lon=" <> longitude <>
    "&appid=2de143494c0b295cca9337e1e96b00e0"
    |> api_call(:forecast)
  end

  defp api_call(url, method_name) do
    url
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> process_response_body(method_name)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "The #{method_name} API doesn't seem to be working"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process_response_body(body,api) do
    body
    |> Poison.decode! 
    |> extract_data(api)
  end

  defp extract_data(response, :weather) do
    response["main"]
  end
  defp extract_data(response, :forecast) do
    # TODO see which data needs extracting
  end
end
