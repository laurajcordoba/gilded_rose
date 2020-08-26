defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  # Add new functionality for Conjured
  def update_item(%Item{name: "Conjured", sell_in: sell_in} = item) when sell_in <= 0 do
    item
    |> reduce_sell_in_by_one()
    |> degrade_quality(4)
  end

  def update_item(%Item{name: "Conjured"} = item) do
    item
    |> reduce_sell_in_by_one()
    |> degrade_quality(2)
  end

  # Rewrite old code for update_item
  def update_item(item)  do
    item
    |> different_aged_backstage()
    |> diff_sulfuras_sellin()
    |> sell_in_less_zero()
  end

  # Helper methods for Conjure functionality
  defp degrade_quality(item, rate) do
    %{item | quality: max(item.quality - rate, 0)}
  end

  defp reduce_sell_in_by_one(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  # Helper methods Refactor
  defp sell_in_less_zero(%Item{sell_in: sell_in} = item) when sell_in < 0 do
    diff_aged(item)
  end

  defp sell_in_less_zero(item) do
    item
  end

  defp diff_aged(%Item{name: name} = item) when name != "Aged Brie" do
    diff_backstate(item)
  end

  defp diff_aged(item) do
    max_quality(item)
  end

  defp increase_quality(item) do
    %{item | quality: item.quality + 1}
  end

  defp max_quality(%Item{quality: quality} = item) when quality < 50 do
    increase_quality(item)
  end

  defp max_quality(item) do
    item
  end

  defp diff_backstate(%Item{name: name} = item) when name != "Backstage passes to a TAFKAL80ETC concert" do
    quality_check(item)
  end

  defp diff_backstate(item) do
    reduce_item_quality(item)
  end

  defp reduce_item_quality(item) do
    %{item | quality: item.quality - item.quality}
  end


  defp quality_check(%Item{quality: quality} = item) when quality > 0 do
    diff_sulfuras_decrease_quality(item)
  end

  defp quality_check(item) do
    item
  end

  defp reduce_item_sellin(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  defp diff_sulfuras_sellin(%Item{name: name} = item) when name != "Sulfuras, Hand of Ragnaros" do
    reduce_item_sellin(item)
  end

  defp diff_sulfuras_sellin(item) do
    item
  end

  defp sell_in_less(%Item{sell_in: sell_in} = item, sell_in_param) when sell_in < sell_in_param do
    max_quality(item)
  end

  defp sell_in_less(%Item{sell_in: sell_in} = item, _sell_in_param) do
    item
  end

  defp diff_sulfuras_decrease_quality(%Item{name: name} = item) when name != "Sulfuras, Hand of Ragnaros" do
    %{item | quality: item.quality - 1}
  end

  defp diff_sulfuras_decrease_quality(item) do
    item
  end

  defp is_backstage(%Item{name: name} = item) when name == "Backstage passes to a TAFKAL80ETC concert" do
    item
    |> sell_in_less(11)
    |> sell_in_less(6)
  end

  defp is_backstage(item) do
    item
  end

  defp increase_quality_and_backstage(%Item{quality: quality} = item) when quality < 50 do
    item
    |> increase_quality()
    |> is_backstage()
  end

  defp increase_quality_and_backstage(item) do
    item
  end

  defp different_aged_backstage(%Item{name: name} = item) when name != "Aged Brie" and name != "Backstage passes to a TAFKAL80ETC concert" do
    quality_check(item)
  end

  defp different_aged_backstage(item)do
    increase_quality_and_backstage(item)
  end
  # New Solution End
end
