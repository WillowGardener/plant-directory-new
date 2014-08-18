class Plant_Traits
  attr_reader(:plant_name, :traits, :attributes)

  def initialize(attributes)
    @plant_name = attributes[:plant_name]
    @traits = attributes[:traits]
    @attributes = attributes
  end



end






