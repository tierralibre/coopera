defmodule Coopera.Server do
  use GenServer
  require Logger


  @default_opts [name: __MODULE__]

  defmodule State do
    defstruct datetime: nil, timer_ref: nil, identity: nil, ccs: nil, cs: nil
  end

  def start_link(opts \\ @default_opts) do
    name = Keyword.get(opts, :name)
    GenServer.start_link(__MODULE__, %State{}, name: {:global, name})
  end

  def schedule(datetime, opts \\ @default_opts) do
    if Mix.env() != :test do
      # TODO This is an extremely inelegant solution to db connection crashes
      # in tests. This problem must be considered very carefully. And please,
      # remove this condition...
      name = Keyword.get(opts, :name)
      GenServer.cast({:global, name}, {:schedule, datetime})
    end
  end

  def init(state) do
    Logger.info "CoopERA Server init"

    Process.send_after(self(), :init_server, 0)

    {:ok, state}
  end

  def handle_info(:init_server, state) do
    now = DateTime.utc_now()
    #schedule
    {:noreply, state}
  end

  def handle_cast({:schedule, datetime}, %State{datetime: nil} = state) do
    {:noreply, state}
  end

  def handle_cast({:schedule, datetime}, state) do
    {:noreply, state}
  end

end
