defmodule DataKeeper do
  use Agent
  def start_link(_initial_value) do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def update(value)  do
    Agent.update(__MODULE__, fn state -> value end)
  end
end
