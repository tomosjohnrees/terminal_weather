defmodule TerminalWeather do
  def main(args) do
    args |> parse_args |> process
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [postcode: :string, api: :string]
    )
    options
  end

  defp process([postcode: "LS118BU", api: _]) do
    IO.puts "Not on my watch!"
  end
  defp process([postcode: postcode, api: api]) do
    case api do
      "weather" -> postcode |> process(api)
      _ -> IO.puts "#{api} hasn't " <>
        "been implemented as a type yet"
    end
  end
  defp process(postcode, api) do
    postcode
    |> PostCode.to_longitude_latitude
    |> Weather.process(api)
    |> Output.process(api)
  end
  defp process(_) do
    IO.puts "invalid input"
    IO.puts "e.g. \n$ ./terminal_weather --postcode=ls42pj --api=weather"
  end
end
