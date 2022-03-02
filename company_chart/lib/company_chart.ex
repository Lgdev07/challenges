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
  def solve(workers) do
    ceo = find_ceo(workers)

    childrens = find_childrens(workers, %{}, parent: ceo)

    final_map = %{
      id: ceo.id,
      name: ceo.name,
      children: childrens
    }

    Jason.encode(final_map)
  end

  defp find_childrens(workers, final_map, opts) do
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
