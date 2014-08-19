require 'rspec'
require 'plant'
require 'spec_helper'

describe Plant do
  it "allows the user to delete a plant from the database" do
    grass = Plant.new({:name => "Grass"})
    grass.save
    grass.delete
    expect(Plant.all).to eq([])
  end

  it "allows the user to add a plant with traits" do
    stinging_nettle = Plant.new({:name => "Stinging Nettle"})
    expect(stinging_nettle.attributes).to eq({:name => "Stinging Nettle"})
  end

  it "allows the user to save a plant to the database and list all plants in the database" do
    white_clover = Plant.new({:name => "White Clover"})
    white_clover.save
    expect(Plant.all).to eq([white_clover])
  end

  it "sets the plant's ID when the user saves it" do
    lupine = Plant.new({:name => "Lupine"})
    lupine.save
    expect(lupine.id).to be_an_instance_of Fixnum
  end

  it "allows the user to update the plant's name" do
    rhubarb = Plant.new({:name => "rhubarb"})
    rhubarb.save
    rhubarb.update("green onion")
    expect(rhubarb.name).to eq "green onion"
  end

  it "allows the user to pull data on which traits a plant has" do
    stinging_nettle = Plant.new({:name => "stinging nettle"})
    stinging_nettle.save

    edible = Trait.new({:trait => "edible"})
    edible.save

    tool_material = Trait.new({:trait => "tool material"})
    tool_material.save

    nutrient_accumulator = Trait.new({:trait => "nutrient accumulator"})
    nutrient_accumulator.save

    medicinal = Trait.new({:trait => "medicinal"})
    medicinal.save

    nettle_medicinal = Plant_Trait.new({:plant_id => stinging_nettle.id, :trait_id => medicinal.id})
    nettle_medicinal.save

    nettle_edible = Plant_Trait.new({:plant_id => stinging_nettle.id, :trait_id => edible.id})
    nettle_edible.save

    nettle_tool_material = Plant_Trait.new({:plant_id => stinging_nettle.id, :trait_id => tool_material.id})
    nettle_tool_material.save

    nettle_accumulator = Plant_Trait.new({:plant_id => stinging_nettle.id, :trait_id => nutrient_accumulator.id})
    nettle_accumulator.save

    expect(stinging_nettle.all_traits).to eq [medicinal, edible, tool_material, nutrient_accumulator]
  end

end

















