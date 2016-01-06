defmodule Output do
  def process(result, "weather") do 
    current_temp = result["temp"] |> Kelvin.to_celsius |> round
    IO.puts "You lazy bastard. It's #{current_temp}°C outside!"
  end
  def process(result, "forecast") do 
  end
end
