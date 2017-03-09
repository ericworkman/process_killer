defmodule Bench do

  def bench(seconds) do
    pid1 = spawn(ProcessKiller, :loop, [0, 'stuff', 'oucnvs'])
    pid2 = spawn(ProcessKiller, :loop, [0, '0123', '972f'])
    send(pid1, {pid2, :yell_forever})
    Process.sleep(seconds * 1000)
    send(pid1, {self(), :count})
    send(pid1, :stop)
    send(pid2, :stop)
    receive do
      message ->
        IO.inspect(message)
    end
  end

  def genbench(seconds) do
    {:ok, pid} = GenServer.start_link(ProcessDestroyer, 0)
    GenServer.cast(pid, :ping)
    Process.sleep(seconds * 1000)
    count = GenServer.call(pid, :get_count)
    IO.inspect count
    GenServer.stop(pid)
  end
end
