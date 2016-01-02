defmodule TerminalWeather do
  def main(args) do
    args |> parse_args |> process
  end

  defp process([]) do
    IO.puts "Please provide a post code"
    IO.puts "e.g. $ ./terminal_weather --post_code=CF446YP"
  end

  defp process([postcode: "LS118BU"]) do
    IO.puts "Not on my watch!"
  end

  defp process([postcode: postcode, api: method_name]) do
    method_name = method_name |> String.to_atom
    case method_name do
      :weather -> postcode |> method(method_name)
      _ -> IO.puts "#{method_name} hasn't " <>
        "been implemented as a type yet"
    end
  end
  
  defp method(postcode, method_name) do
    postcode
    |> PostCode.to_longitude_latitude
    |> Weather.method(method_name)
    |> output(method_name)
  end

  defp output(result, :weather) do 
    current_temp = result["temp"] |> Kelvin.to_celsius |> round
    IO.puts "You lazy bastard. It's #{current_temp}°C outside!"
  end
  defp output(result, :forecast) do 
    
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [postcode: :string, api: :string]
    )
    options
  end
end
