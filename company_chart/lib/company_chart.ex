defmodule CompanyChart do
  @moduledoc """
  This module is a resolution of the exercise:
  https://pastebin.com/80RqrwUV
  """

  @doc """
  Hello world.

  ## Examples

      iex> CompanyChart.hello()
      :world

  """
  def solve() do
    workers = 
    [
      %{id: 1, name: "CEO", parent_id: nil },
      %{id: 2, name: "CTO", parent_id: 1 },
      %{id: 3, name: "CFO", parent_id: 1 },
      %{id: 4, name: "Manager 1", parent_id: 2 },
      %{id: 5, name: "Manager 2", parent_id: 2 }
    ]

    ceo = find_ceo(workers)

    childrens = find_childrens(workers, %{}, parent: ceo)

    %{
      id: ceo.id,
      name: ceo.name,
      children: childrens
    }
  end

  defp find_childrens(workers, final_map, opts \\ []) do
    parent = Keyword.get(opts, :parent)

    childrens = Enum.filter(workers, fn x -> x.parent_id == parent.id end)
    
    Enum.map(childrens, fn x -> 
      %{
        id: x.id,
        name: x.name,
        children: find_childrens(workers, final_map, parent: x)
      }
    end)
  end

  defp find_ceo(workers) do
    Enum.find(workers, fn x -> is_nil(x.parent_id) end)
  end
end
