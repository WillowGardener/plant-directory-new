class Plant_Traits
  attr_reader(:plant_name, :traits, :attributes, :id)

  def initialize(attributes)
    @plant_name = attributes[:plant_name]
    @traits = attributes[:traits]
    @attributes = attributes
    @id = attributes[:id]
  end

  def save
    DB.exec("INSERT INTO plants (plant_name) VALUES ('#{@plant_name}') RETURNING id;")
    @traits.each do |trait|
      DB.exec("INSERT INTO traits (trait_name) VALUES ('#{trait}') RETURNING id;")
    end
  end


end






