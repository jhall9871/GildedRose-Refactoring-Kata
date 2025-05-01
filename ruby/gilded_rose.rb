class GildedRose

  LEGENDARY_ITEMS = ["Sulfuras, Hand of Ragnaros"]
  BETTER_WITH_AGE_ITEMS = ["Aged Brie"]
  WAY_BETTER_WITH_AGE_ITEMS = ["Backstage passes to a TAFKAL80ETC concert"]
  CONJURED_ITEMS = ["Conjured Mana Cake"]
  QUALITY_LIMIT = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      return if LEGENDARY_ITEMS.include? item.name

      quality_change = 0
      quality_change += 1 if BETTER_WITH_AGE_ITEMS.include? item.name
      quality_change += 2 if WAY_BETTER_WITH_AGE_ITEMS.include? item.name
      quality_change += 1 if item.sell_in < 11 && WAY_BETTER_WITH_AGE_ITEMS.include?(item.name)
      quality_change += 1 if item.sell_in < 6 && WAY_BETTER_WITH_AGE_ITEMS.include?(item.name)
      quality_change -= 2 if CONJURED_ITEMS.include? item.name

      new_quality = item.quality + quality_change
      new_quality = 0 if new_quality < 0
      new_quality = QUALITY_LIMIT if new_quality > QUALITY_LIMIT
      item.quality = new_quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
