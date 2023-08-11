class GildedRose

  def initialize(items)
    @items = items
  end

  def ordinary_item(item)
     item.quality -= 1 if item.quality > 0
  end

  def aged_brie(item)
     item.quality += 1 if item.quality < 50
  end

  def backstage_pass(item)
    item.quality += 1 if item.quality < 50
    if item.sell_in < 6
      item.quality += 1 if item.quality < 50
    end
    if item.sell_in < 11
      item.quality += 1 if item.quality < 50
    end
  end

  def update_quality()
    @items.each do |item|
      next if item.name.eql? "Sulfuras, Hand of Ragnaros"

      
      if item.name.eql? "Aged Brie"
          aged_brie(item)
      elsif item.name.eql? "Backstage passes to a TAFKAL80ETC concert"
          backstage_pass(item)
      else item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        ordinary_item(item)
      end
      item.sell_in = item.sell_in - 1
      
      if item.sell_in < 0
        if item.name.eql? "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        elsif item.name.eql? "Aged Brie"
          aged_brie(item)
        else
          ordinary_item(item)
        end
      end
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
