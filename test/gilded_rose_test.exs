defmodule GildedRoseTest do
  use ExUnit.Case

  describe "Generic item" do
    test "quality degrades by one" do
      item = %Item{
        name: "Generic Item",
        sell_in: 10,
        quality: 20
      }
      next_item = GildedRose.update_item(item)

      assert next_item.quality == 19
    end

    test "quality degrades by two after sell by date" do
      item = %Item{
        name: "Generic Item",
        sell_in: -1,
        quality: 20
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end

    test "quality never becomes negative" do
      item = %Item{
        name: "Generic Item",
        sell_in: 10,
        quality: 0
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end
  end

  describe "Aged Brie" do
    test "quality increases" do
      item = %Item{
        name: "Aged Brie",
        sell_in: 10,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by two after sell date" do
      item = %Item{
        name: "Aged Brie",
        sell_in: -1,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 32
    end

    test "quality never becomes more than 50" do
      item = %Item{
        name: "Aged Brie",
        sell_in: 10,
        quality: 50
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 50
    end
  end

  describe "Sulfuras" do
    test "quality is always 80" do
      item = %Item{
        name: "Sulfuras, Hand of Ragnaros",
        sell_in: 10,
        quality: 80
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 80
    end

    test "sell date never changes" do
      item = %Item{
        name: "Sulfuras, Hand of Ragnaros",
        sell_in: 10,
        quality: 80
      }
      next_item = GildedRose.update_item(item)
      assert next_item.sell_in == 10
    end
  end

  describe "Backstage Passes" do
    test "quality increases" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 15,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by 2 when 10 days or less" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 10,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 32
    end

    test "quality increases by 3 when 5 days or less" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 5,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 33
    end

    test "quality is 0 when expired" do
      item = %Item{
        name: "Backstage passes to a TAFKAL80ETC concert",
        sell_in: 0,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end
  end

  describe "Conjured" do
    test "quality degrades by two" do
      item = %Item{
        name: "Conjured",
        sell_in: 20,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 28
    end

    test "quality degrades by four" do
      item = %Item{
        name: "Conjured",
        sell_in: -1,
        quality: 30
      }
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 26
    end
  end
end
