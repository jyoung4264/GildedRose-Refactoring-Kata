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
    if item.sell_in < 6
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
    if item.sell_in < 11
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end

  def update_quality()
    @items.each do |item|
      next if item.name.eql? "Sulfuras, Hand of Ragnaros"

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        ordinary_item(item)
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            backstage_pass(item)
          end
        end
      end
      item.sell_in = item.sell_in - 1
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            ordinary_item(item)
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
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
