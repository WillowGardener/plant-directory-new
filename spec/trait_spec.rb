require 'trait'
require 'rspec'
require 'pg'



describe Trait do
  it "allows the user to add a trait" do
    trait = Trait.new({:trait => "nutrient accumulator"})
    expect(trait).to be_an_instance_of Trait
  end
end
