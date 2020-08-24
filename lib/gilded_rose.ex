defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
    |> set_quality(80)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) when sell_in <= 0 do
    item
    |> reduce_sell_in_by_one()
    |> upgrade_quality(2)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item
    |> reduce_sell_in_by_one()
    |> upgrade_quality(1)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in} = item) when sell_in <= 0 do
    item
    |> reduce_sell_in_by_one()
    |> set_quality(0)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in} = item) when sell_in <= 5 do
    item
    |> reduce_sell_in_by_one()
    |> upgrade_quality(3)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in} = item) when sell_in <= 10 do
    item
    |> reduce_sell_in_by_one()
    |> upgrade_quality(2)
  end

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    item
    |> reduce_sell_in_by_one()
    |> upgrade_quality(1)
  end

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

  # def update_item(%Item{name: _name, sell_in: sell_in, quality: _quality} = item) when sell_in <= 0 do
  def update_item(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    item
    |> reduce_sell_in_by_one()
    |> degrade_quality(2)
  end

  # def update_item(%Item{name: _name, sell_in: _sell_in, quality: _quality} = item) do
  def update_item(item) do
    item
    |> reduce_sell_in_by_one()
    |> degrade_quality(1)
  end

  # Private methods
  defp reduce_sell_in_by_one(item) do
    %Item{item | sell_in: item.sell_in - 1}
  end

  defp degrade_quality(item, rate) do
    %Item{item | quality: max(item.quality - rate, 0)}
  end

  defp upgrade_quality(item, rate) do
    %Item{item | quality: min(item.quality + rate, 50)}
  end

  defp set_quality(item, quality) do
    %Item{item | quality: quality}
  end


  # ******************
  # def update_item(item) do
  #   item = cond do
  #     item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
  #       if item.quality > 0 do
  #         if item.name != "Sulfuras, Hand of Ragnaros" do
  #           %{item | quality: item.quality - 1}
  #         else
  #           item
  #         end
  #       else
  #         item
  #       end
  #     true ->
  #       cond do
  #         item.quality < 50 ->
  #           item = %{item | quality: item.quality + 1}
  #           cond do
  #             item.name == "Backstage passes to a TAFKAL80ETC concert" ->
  #               item = cond do
  #                 item.sell_in < 11 ->
  #                   cond do
  #                     item.quality < 50 ->
  #                       %{item | quality: item.quality + 1}
  #                     true -> item
  #                   end
  #                 true -> item
  #               end
  #               cond do
  #                 item.sell_in < 6 ->
  #                   cond do
  #                     item.quality < 50 ->
  #                       %{item | quality: item.quality + 1}
  #                     true -> item
  #                   end
  #                 true -> item
  #               end
  #             true -> item
  #           end
  #         true -> item
  #       end
  #   end
  #   item = cond do
  #     item.name != "Sulfuras, Hand of Ragnaros" ->
  #       %{item | sell_in: item.sell_in - 1}
  #     true -> item
  #   end
  #   cond do
  #     item.sell_in < 0 ->
  #       cond do
  #         item.name != "Aged Brie" ->
  #           cond do
  #             item.name != "Backstage passes to a TAFKAL80ETC concert" ->
  #               cond do
  #                 item.quality > 0 ->
  #                   cond do
  #                     item.name != "Sulfuras, Hand of Ragnaros" ->
  #                       %{item | quality: item.quality - 1}
  #                     true -> item
  #                   end
  #                 true -> item
  #               end
  #             true -> %{item | quality: item.quality - item.quality}
  #           end
  #         true ->
  #           cond do
  #             item.quality < 50 ->
  #               %{item | quality: item.quality + 1}
  #             true -> item
  #           end
  #       end
  #     true -> item
  #   end
  # end
end
