defmodule ProcessKiller do

  def loop(count, stuff, stuff2) do
    receive do
      {sender_pid, :count} ->
        send(sender_pid, {:ok, count})
      {pid_to_send_to, :yell_forever} ->
        send(pid_to_send_to, {self(), :yell_forever})
      :stop ->
        exit(:normal)
      _ ->
        IO.puts "#{inspect self()}don't know how to process this message"
    end
    loop(count + 1, stuff, stuff2)
  end
end
