require 'pg'
require 'plant_traits'
require 'trait'

class Plant
  attr_reader(:attributes, :name, :id)

  def initialize(attributes)
    @attributes = attributes
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO plants (plant_name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM plants;")
    plants = []
    results.each do |r|
      plant_name = r['plant_name']
      id = r['id'].to_i
      plants << Plant.new({:name => plant_name, :id => id})
    end
    plants
  end

  def ==(another_plant)
    self.name == another_plant.name
  end

  def delete
    DB.exec("DELETE FROM plants WHERE id = (#{self.id})")
  end

  def update(new_name)
    DB.exec("UPDATE plants SET plant_name = ('#{new_name}') WHERE id = ('#{self.id}')")
    @name = new_name
  end

  def all_traits
    all_traits = []
    results = DB.exec("select traits.* from plants join plant_traits on (plants.id = plant_traits.plant_id) join traits on (plant_traits.trait_id = traits.id) where plants.id = ('#{self.id}')")
    results.each do |r|
      all_traits << Trait.new({:trait => r['trait_name'], :id => r['id'].to_i})
    end
    # all_traits = all_traits.sort
    all_traits
  end

end
