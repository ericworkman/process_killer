defmodule Bench do
  
  def bench(seconds) do
    pid1 = spawn(ProcessKiller, :loop, [0])
    pid2 = spawn(ProcessKiller, :loop, [0])
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

end
