require 'rspec'
require 'plant'
require 'pg'

DB = PG.connect({:dbname => 'plant_directory_test'})

describe Plant do
  it "allows the user to add a plant with traits" do
    stinging_nettle = Plant.new({:name => "Stinging Nettle", :traits => ["edible", "medicinal", "tool material", "nutrient accumulator"]})
    expect(stinging_nettle.attributes).to eq({:name => "Stinging Nettle", :traits => ["edible", "medicinal", "tool material", "nutrient accumulator"]})
  end

  it "allows the user to save a plant to the database and list all plants in the database" do
    white_clover = Plant.new({:name => "White Clover", :traits => ["nutrient accumulator"]})
    white_clover.save
    expect(Plant.all).to eq([white_clover])
  end
end
