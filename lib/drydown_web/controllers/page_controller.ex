defmodule DrydownWeb.PageController do
  use DrydownWeb, :controller

  def index(conn, _params) do
    current_weight = DataKeeper.value
    render(conn, "index.html", weight: current_weight)
  end
end
