defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.reject(inventory, &(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item -> 
      Map.replace(item, :name, String.replace(item.name, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    new_quantities = item[:quantity_by_size] 
      |> Map.to_list 
      |> Map.new(fn {key, size} -> {key, size + count} end)
    Map.replace(item, :quantity_by_size, new_quantities)
  end

  def total_quantity(item) do
    item[:quantity_by_size] 
      |> Map.to_list 
      |> Enum.reduce(0, fn {_, quantity}, acc -> acc + quantity end) 
  end
end
