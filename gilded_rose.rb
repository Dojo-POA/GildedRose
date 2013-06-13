require './item.rb'

class GildedRose

  attr_reader :items
  @items = []

  def item_by_name(name)
    items.detect{|i| i.name == name}
  end

  def initialize(items = [])
    @items = items
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    items.each { |item| update item }
  end

  private
  def update item
    strategy_for(item.name).call item
  end

  def strategy_for item_name
    updators = {
      "Aged Brie" => method(:update_aged_brie),
      "Sulfuras, Hand of Ragnaros" => proc {},
      "Backstage passes to a TAFKAL80ETC concert" => method(:update_ticket), 
    }
    updators.fetch(item_name, method(:normal_strategy))
  end

  def update_aged_brie item
    item.quality = [50, item.quality + 1].min
    item.sell_in -= 1
  end

 def normal_strategy item
    item.quality = [0, item.quality - 1].max
    item.sell_in -= 1
  end

  def update_ticket item
    item.sell_in < 11 && item.quality += 1
    item.sell_in < 6  && item.quality += 1

    item.quality = [50, item.quality + 1].min
    item.sell_in = item.sell_in - 1
    item.sell_in < 0 && item.quality = 0
  end

end