defmodule CompanyChartTest do
  use ExUnit.Case

  test "return the company nested chart in json" do
    assert CompanyChart.solve(company_workers()) ==
             {
               :ok,
               "{\"children\":[{\"children\":[{\"children\":[],\"id\":4,\"name\":\"Manager 1\"},{\"children\":[],\"id\":5,\"name\":\"Manager 2\"}],\"id\":2,\"name\":\"CTO\"},{\"children\":[],\"id\":3,\"name\":\"CFO\"}],\"id\":1,\"name\":\"CEO\"}"
             }
  end

  defp company_workers do
    [
      %{id: 1, name: "CEO", parent_id: nil},
      %{id: 2, name: "CTO", parent_id: 1},
      %{id: 3, name: "CFO", parent_id: 1},
      %{id: 4, name: "Manager 1", parent_id: 2},
      %{id: 5, name: "Manager 2", parent_id: 2}
    ]
  end
end
