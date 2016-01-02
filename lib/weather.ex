defmodule Weather do
  def method([longitude: longitude, latitude: latitude], method_name) do
    url(longitude, latitude, method_name)
    |> api_call(method_name)
  end

  def url(longitude, latitude, method_name) do
    "http://api.openweathermap.org/data/2.5/" <>
    "#{ method_name |> to_string }?" <>
    "lat=" <> latitude <>
    "&lon=" <> longitude <>
    "&appid=2de143494c0b295cca9337e1e96b00e0"
  end

  defp api_call(url, method_name) do
    url
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> process_response_body(method_name)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "The #{method_name |> to_string }" <>
        "API doesn't seem to be working"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp process_response_body(body, method_name) do
    body
    |> Poison.decode! 
    |> extract_data(method_name)
  end

  defp extract_data(response, :weather) do
    response["main"]
  end
  defp extract_data(response, :forecast) do
    # TODO see which data needs extracting
  end
end
