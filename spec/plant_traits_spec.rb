require 'spec_helper'


describe Plant_Traits do
  it "allows a user to submit a plant's name and its traits" do
    stinging_nettle = Plant_Traits.new({:plant_name => "stinging nettle", :traits => ["edible", "medicinal", "nutrient accumulator"]})
    expect(stinging_nettle.attributes).to eq ({:plant_name => "stinging nettle", :traits => ["edible", "medicinal", "nutrient accumulator"]})
  end
  # it "allows a user to save data to the plant and traits tables and return their id" do
  #   yarrow = Plant_Traits.new({:plant_name => "yarrow", :traits => ["cover crop"]})
  #   yarrow.save
  #   expect(yarrow.id).to be_an_instance_of Fixnum
  # end
end
