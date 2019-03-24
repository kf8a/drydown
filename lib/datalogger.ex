defmodule Datalogger do

  def run do
    case Ohaus.read() do
      {:ok, weight } -> handle_weight(weight)
      :error -> :error
    end
  end

  def handle_weight(weight) do
    save_data(weight)
    DataKeeper.update(weight)
    DrydownWeb.Endpoint.broadcast("weight:scale", "new_msg", %{"weight" => weight })
  end

  def save_data(weight) do
    {:ok, table} = :dets.open_file(:disk_storage, [type: :set])
    :dets.insert_new(table, {DateTime.utc_now, weight})
    :dets.close(table)
  end

  def as_array(data) do
    {time, weight} = data
    [time, weight]
  end

  # def line([head | tail]) do
  #   {time, weight} = head
  #   [time, weight]
  #   line(tail)
  # end
  #
  # def line(head | []) do
  #   {time, weight} = head
  #   [time, weight]
  # end
end
