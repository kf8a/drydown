defmodule OhausReader do

  def init() do
     {:ok, pid} = Circuits.UART.start_link
     IO.inspect Circuits.UART.open(pid, "ttyUSB0", speed: 9600, active: false, framing: {Circuits.UART.Framing.Line, separator: "\r\n"})
     {:ok, pid}
  end

  def read_checked(pid) do
    {weight1, _} = read(pid)
    {weight2, _} = read(pid)
    # this will blow if read returns :error
    diff = weight1 - weight2
    if diff < 0.1 do
      {:ok, weight1}
    else
      :error
    end
  end

  def read(pid) do
    pre_read(pid)
    |> read_scale
    |> parse_weight
  end

  def pre_read(pid) do
     Circuits.UART.flush(pid)
     # do a read to clear out partial lines
     read_scale(pid)
     pid
  end

  def read_scale(pid) do
     Circuits.UART.read(pid, 6000)
     |> IO.inspect
  end

  def close(pid) do
     Circuits.UART.close(pid)
  end


  def parse_weight({:ok, data}) do
    %{"weight" => weight} = Regex.named_captures(~r/(?<weight>-?\d+).+g.+N/,data)
    Float.parse(weight)
  end

  def parse_weight({:error, :ebadf}) do
    { :error , "no scale found"}
  end

  def test(pid) do
    IO.inspect read_checked(pid)
    test(pid)
  end
end
