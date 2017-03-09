defmodule ProcessDestroyer do
  use GenServer

  def handle_cast(:ping, count) do
    GenServer.cast(self(), :pong)
    {:noreply, count + 1}
  end

  def handle_cast(:pong, count) do
    GenServer.cast(self(), :ping)
    {:noreply, count + 1}
  end

  def handle_call(:get_count, _from, count) do
    {:reply, count, count}
  end
end
