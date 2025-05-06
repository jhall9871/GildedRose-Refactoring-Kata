require File.join(File.dirname(__FILE__), 'gilded_rose')
# require_relative 'texttest_fixture'
require 'rspec'
describe GildedRose do
  let(:items) do
    [
      Item.new(name: 'Sulfuras, Hand of Ragnaros', sell_in: 10, quality: 80),
      Item.new(name: 'Normal Item', sell_in: 10, quality: 20),
      Item.new(name: 'Aged Brie', sell_in: 10, quality: 20),
      Item.new(name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 10, quality: 20),
      Item.new(name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 5, quality: 20),
      Item.new(name: 'Conjured Mana Cake', sell_in: 10, quality: 20),
      Item.new(name: 'Normal Item', sell_in: 0, quality: 0),
      Item.new(name: 'Aged Brie', sell_in: 10, quality: 50)
    ]
  end

  let(:gilded_rose) { GildedRose.new(items) }

  describe '#update_quality' do
    it 'does not change the quality of legendary items' do  
      gilded_rose.update_quality
      expect(items[0].quality).to eq(80)
    end

    it 'decreases the quality of normal items by 1' do
      gilded_rose.update_quality
      expect(items[1].quality).to eq(19)
    end

    it 'increases the quality of aged brie items by 1' do
      gilded_rose.update_quality
      expect(items[2].quality).to eq(21)
    end

    it 'increases the quality of backstage passes items by 1' do
      gilded_rose.update_quality
      expect(items[3].quality).to eq(21)
    end

    it 'increases the quality of backstage passes items by 2 when sell_in is 10 or less' do
      gilded_rose.update_quality
      expect(items[4].quality).to eq(22)
    end

    it 'decreases the quality of conjured items by 2' do
      gilded_rose.update_quality
      expect(items[5].quality).to eq(18)
    end

    it 'does not decrease the quality of items below 0' do
      gilded_rose.update_quality
      expect(items[6].quality).to eq(0)
    end

    it 'does not increase the quality of items above 50' do
      gilded_rose.update_quality
      expect(items[7].quality).to eq(50)
    end
  end
end