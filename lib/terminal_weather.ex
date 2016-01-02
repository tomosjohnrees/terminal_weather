defmodule TerminalWeather do
  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    IO.puts "Please provide a post code"
    IO.puts "e.g. $ ./terminal_weather --post_code=CF446YP"
  end

  def process([postcode: "LS118BU"]) do
    IO.puts "Not on my watch!"
  end

  def process([postcode: postcode]) do
    weather = postcode
    |> PostCode.to_longitude_latitude
    |> Weather.weather

    current_temp = weather["temp"] |> Kelvin.to_celsius |> round

    IO.puts "You lazy bastard. It's #{current_temp}°C outside!"
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [postcode: :string]
    )
    options
  end
end
