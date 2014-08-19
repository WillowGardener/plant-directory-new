require 'pg'
require 'plant_traits'
require 'plant'

class Trait
  attr_reader(:trait, :attributes, :id)

  def initialize(attributes)
    @attributes = attributes
    @trait = attributes[:trait]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO traits (trait_name) VALUES ('#{@trait}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    traits = []
    results = DB.exec("SELECT * FROM traits;")
    results.each do |r|
      trait_name = r['trait_name']
      id = r['id'].to_i
      traits << Trait.new({:trait => trait_name, :id => id})
    end
    traits
  end

  def ==(another_trait)
    self.trait == another_trait.trait
  end

  def delete
    DB.exec("DELETE FROM traits WHERE id = (#{self.id})")
  end

  def update(new_trait)
    DB.exec("UPDATE traits SET trait_name = ('#{new_trait}') WHERE id = ('#{self.id}')")
    @trait = new_trait
  end

  def all_plants
    all_plants = []
    results = DB.exec("select plants.* from traits join plant_traits on (traits.id = plant_traits.trait_id) join plants on (plant_traits.plant_id = plants.id) where traits.id = ('#{self.id}')")
    results.each do |r|
      all_plants << Plant.new({:name => r['plant_name'], :id => r['id'].to_i})
    end
    all_plants
  end


end
