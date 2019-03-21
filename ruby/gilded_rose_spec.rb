require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decrease item quality" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be < 10
    end

    it "item quality cannot be negative" do
      items = [Item.new("foo", 0, -1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be >= 0
    end

    it "Aged Brie quality cannot decreases" do
      items = [Item.new("Aged Brie", -1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be > 1
    end

    it "item quality should be less or equal 50" do
      items = [Item.new("bar", 1, 52)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be <= 50
    end

    it "quality alway should be 80 for Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 60)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  eq 80
    end

    it "quality cannot change for Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  eq 80
    end

    it "increase quality by 3 if 6 or less day remain for Backstage" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be > 3
    end

    it "increase quality by 2 if 10 or less day remain for Backstage" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  be > 2
    end

    it "quality should 0 for Backstage sell out days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to  eq 0
    end
  end

end
