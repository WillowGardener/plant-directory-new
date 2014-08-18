require 'spec_helper'


describe Plant_Traits do
  it "allows a user to submit a plant's name and its traits" do
    stinging_nettle = Plant_Traits.new({:plant_name => "stinging nettle", :traits => ["edible", "medicinal", "nutrient accumulator"]})
    expect(stinging_nettle.attributes).to eq ({:plant_name => "stinging nettle", :traits => ["edible", "medicinal", "nutrient accumulator"]})
  end
end
