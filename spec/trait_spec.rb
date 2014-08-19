require 'spec_helper'

describe Trait do
  it "allows the user to delete a trait from the database" do
    grass = Trait.new({:name => "Grass"})
    grass.save
    grass.delete
    expect(Trait.all).to eq([])
  end

  it "allows the user to add a trait" do
    trait = Trait.new({:trait => "nutrient accumulator"})
    expect(trait).to be_an_instance_of Trait
  end

  it "allows the user to save and list traits" do
    medicinal = Trait.new({:trait => "medicinal"})
    medicinal.save
    expect(Trait.all).to eq ([medicinal])
  end

  it "sets the trait's ID when the user saves it" do
    nitrogen_fixer = Trait.new({:trait => "nitrogen fixing"})
    nitrogen_fixer.save
    expect(nitrogen_fixer.id).to be_an_instance_of Fixnum
  end

  it "allows the user to update the plant's name" do
    poisonous = Trait.new({:trait => "edible"})
    poisonous.save
    poisonous.update("delicious")
    expect(poisonous.trait).to eq "delicious"
  end

  it "allows the user to pull data on which plants have these traits" do
    edible = Trait.new({:trait => "edible"})
    edible.save
    raspberry = Plant.new({:name => "raspberry"})
    raspberry.save
    strawberry = Plant.new({:name => "strawberry"})
    strawberry.save
    edible_straw = Plant_Trait.new(:plant_id => strawberry.id, :trait_id => edible.id)
    edible_straw.save
    edible_rasp = Plant_Trait.new(:plant_id => raspberry.id, :trait_id => edible.id)
    edible_rasp.save
    expect(edible.all_plants).to eq [strawberry, raspberry]
  end

end









