require 'spec_helper'


describe Plant_Trait do
  it "allows a user to save a relation between a plant and a trait" do
    yarrow = Plant.new({:name => "Yarrow"})
    cover_crop = Trait.new({:trait => "cover crop"})
    yarrow.save
    cover_crop.save
    yarrow_cover = Plant_Trait.new({:plant_id => yarrow.id, :trait_id => cover_crop.id})
    yarrow_cover.save
    expect(Plant_Trait.all).to eq([yarrow_cover])
  end
end
