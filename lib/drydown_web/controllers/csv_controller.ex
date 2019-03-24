defmodule DrydownWeb.CsvController do
  use DrydownWeb, :controller

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"drydown-weights.csv\"")
    |> send_resp(200, csv_content)
  end

  def csv_content() do
    {:ok, table} = :dets.open_file(:disk_storage, [type: :set])
    # ms = :ets.fun2ms fn {time, weight} -> [time, weight] end
    :dets.select(table, [{{:"$1", :"$2"}, [], [[:"$1", :"$2"]]}])
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end
end
