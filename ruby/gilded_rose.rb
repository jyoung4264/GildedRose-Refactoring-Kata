class GildedRose

  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def ordinary_item(item)
     item.quality -= 1
  end

  def aged_brie(item)
     item.quality += 1
  end

  def backstage_pass(item)
    case item.sell_in
    when 0..5
      item.quality += 3
    when 6..10
      item.quality += 2
    when 11..Float::INFINITY
      item.quality += 1
    end
  end

  def is_ordinary_item?(item)
    item.name != "Aged Brie" and 
    item.name != "Backstage passes to a TAFKAL80ETC concert" and 
    item.name != "Sulfuras, Hand of Ragnaros"
  end

  def max_quality(item)
    item.quality = MAXIMUM_QUALITY if item.quality > MAXIMUM_QUALITY
  end

  def min_quality(item)
    item.quality = MINIMUM_QUALITY if item.quality < MINIMUM_QUALITY
  end

  def update_quality()
    @items.each do |item|

      next if item.name.eql? "Sulfuras, Hand of Ragnaros"
          
      aged_brie(item) if item.name.eql? "Aged Brie"
      backstage_pass(item) if item.name.eql? "Backstage passes to a TAFKAL80ETC concert"
      ordinary_item(item) if is_ordinary_item?(item)

      item.sell_in -= 1
      
      if item.sell_in < 0
        item.quality = 0 if item.name.eql? "Backstage passes to a TAFKAL80ETC concert"
        aged_brie(item) if item.name.eql? "Aged Brie"
        ordinary_item(item) if is_ordinary_item?(item)
      end
      max_quality(item)
      min_quality(item)
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
