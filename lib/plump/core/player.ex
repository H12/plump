defmodule Plump.Core.Player do
  defstruct name: nil

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end
