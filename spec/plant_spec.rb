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

end
