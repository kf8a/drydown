defmodule DrydownWeb.WeightChannel do
  use Phoenix.Channel

  def join("weight:scale", _message, socket) do
    {:ok, socket}
  end
end
