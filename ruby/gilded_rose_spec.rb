require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "expected result" do
    before do
      items = [
        Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
        Item.new(name="Aged Brie", sell_in=2, quality=0),
        Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
        Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
        Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
        Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
        # This Conjured item does not work properly yet
        Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
      ]
      days = 31
      test_output = File.new("ruby/test_output.txt", 'w')
      test_output.write("OMGHAI!")
      test_output.write( "\n" )
      gilded_rose = GildedRose.new items
        (0...days).each do |day|
          test_output.write( "-------- day #{day} --------\n")
          test_output.write( "name, sellIn, quality\n" )
          items.each do |item|
            test_output.write( item )
            test_output.write( "\n" )
          end
          test_output.write( "\n")
          gilded_rose.update_quality
        end
        test_output.close()
    end
    it "matches expected output" do
      standard_output = File.open("texttests/ThirtyDays/stdout.gr").read()
      new_output = File.open("ruby/test_output.txt").read()
      expect(new_output).to eq(standard_output)
    end
  end
end

