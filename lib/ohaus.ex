defmodule Ohaus do
  def read() do
    {:ok, pid} = OhausReader.init()
    result = OhausReader.read_checked(pid)
    OhausReader.close(pid)
    result
  end
end
