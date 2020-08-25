defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  # Add new functionality for Conjured
  def update_item(%Item{name: name, sell_in: sell_in} = item) when name == "Conjured" and sell_in <= 0 do
    item
    |> reduce_sell_in_by_one()
    |> degrade_quality(4)
  end

  def update_item(%Item{name: name} = item) when name == "Conjured" do
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
    item
    |> diff_aged()
  end

  defp sell_in_less_zero(item) do
    item
  end

  defp diff_aged(%Item{name: name} = item) when name != "Aged Brie" do
    item
    |> diff_backstate()
  end

  defp diff_aged(item) do
    item
    |> max_quality()
  end

  defp increase_quality(item) do
    %{item | quality: item.quality + 1}
  end

  defp max_quality(%Item{quality: quality} = item) when quality < 50 do
    item
    |> increase_quality()
  end

  defp max_quality(item) do
    item
  end

  defp diff_backstate(%Item{name: name} = item) when name != "Backstage passes to a TAFKAL80ETC concert" do
    item
    |> quality_check()
  end

  defp diff_backstate(item) do
    item
    |> reduce_item_quality()
  end

  defp reduce_item_quality(item) do
    %{item | quality: item.quality - item.quality}
  end


  defp quality_check(%Item{quality: quality} = item) when quality > 0 do
    item
    |> diff_sulfuras_decrease_quality()
  end

  defp quality_check(item) do
    item
  end

  defp reduce_item_sellin(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  defp diff_sulfuras_sellin(%Item{name: name} = item) when name != "Sulfuras, Hand of Ragnaros" do
    item
    |> reduce_item_sellin()
  end

  defp diff_sulfuras_sellin(%Item{name: name} = item) do
    item
  end

  defp sell_in_less_11(%Item{sell_in: sell_in} = item) when sell_in < 11 do
    item
    |> max_quality()
  end

  defp sell_in_less_11(item) do
    item
  end

  defp sell_in_less_6(%Item{sell_in: sell_in} = item) when sell_in < 6 do
    item
    |> max_quality()
  end

  defp sell_in_less_6(item) do
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
    |> sell_in_less_11()
    |> sell_in_less_6()
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
    item
    |> quality_check()
  end

  defp different_aged_backstage(item)do
    item
    |> increase_quality_and_backstage()
  end
  # New Solution End
end
