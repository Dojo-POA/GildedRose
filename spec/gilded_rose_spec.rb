require './gilded_rose.rb'
require "rspec"

describe GildedRose do

  describe "Normal Items" do

    let(:item) do
      subject.item_by_name "+5 Dexterity Vest"
    end

    it "should have a sell in period, which decreases after update" do
      old = item.sell_in
      subject.update_quality
      item.sell_in.should == (old - 1)
    end

    it "should decrease quality by 1 after update" do
      old = item.quality
      subject.update_quality
      item.quality.should == (old - 1)
    end
  end

  describe "Aged Brie" do
    let(:item) do
      subject.item_by_name "Aged Brie"
    end

    it "should never have quality bigger than 50" do
      item = Item.new('Aged Brie', 10, 50)
      subject = GildedRose.new [item]

      subject.update_quality

      item.quality.should == 50
    end

    it "should have a sell in period, which decreases after update" do
      old = item.sell_in
      subject.update_quality
      item.sell_in.should == (old - 1)
    end

    it "should increase in quality as it ages" do
      old = item.quality
      subject.update_quality
      item.quality.should == old + 1
    end
  end

  describe "Sulfuras, Hand of Ragnaros" do
    let(:item) do
      subject.item_by_name "Sulfuras, Hand of Ragnaros"
    end

    it "should have a sell in period, which never change after update" do
      old = item.sell_in
      subject.update_quality
      item.sell_in.should == old
    end

    it "should never decrease quality after update" do
      old = item.quality
      subject.update_quality
      item.quality.should == old
    end  
  end

  describe "Backstage passes to a TAFKAL80ETC concert" do
    let(:item) do
      subject.item_by_name "Backstage passes to a TAFKAL80ETC concert"
    end

    it "should have a sell in period, which decreases after update" do
      old = item.sell_in
      subject.update_quality
      item.sell_in.should == old - 1     
    end

    it "should increase quality by 1 when there are more than 10 days" do
      old = item.quality
      subject.update_quality
      item.quality.should == old + 1
    end

    it "should increase quality by 2 when there are between 10 and 5 days left" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)
      subject = GildedRose.new [item]  

      old = item.quality
      subject.update_quality
      item.quality.should == old + 2
    end

    it "should increase quality by 2 when there are 5 days left" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)
      subject = GildedRose.new [item]  

      old = item.quality
      subject.update_quality
      item.quality.should == old + 3
    end

    it "should not value nothing" do
      item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
      subject = GildedRose.new [item]

      old = item.quality
      subject.update_quality
      item.quality.should == 0
    end

  end

end
