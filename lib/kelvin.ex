defmodule Kelvin do
  def to_celsius(k), do: k - 273.15
 
  def to_fahrenheit(k), do: (k - 273.15) * 1.8 + 32
end
