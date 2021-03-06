require 'pg'

class Plant_Trait
  attr_reader(:plant_id, :trait_id, :attributes, :id)

  def initialize(attributes)
    @plant_id = attributes[:plant_id]
    @trait_id = attributes[:trait_id]
    @attributes = attributes
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO plant_traits (plant_id, trait_id) VALUES ('#{@plant_id}', '#{@trait_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    plant_traits = []
    results = DB.exec("SELECT * FROM plant_traits;")
    results.each do |r|
      plant_id = r['plant_id'].to_i
      trait_id = r['trait_id'].to_i
      id = r['id'].to_i
      plant_traits << Plant_Trait.new({:plant_id => plant_id, :trait_id => trait_id, :id => id})
    end
    plant_traits
  end

  def ==(another_plant_trait)
    self.id == another_plant_trait.id
  end

  def delete
    DB.exec("DELETE FROM plant_traits WHERE id = (#{self.id})")
  end

  def update_plant_id(new_plant_id)
    DB.exec("UPDATE plant_traits SET plant_id = ('#{new_plant_id}') WHERE id = ('#{self.id}')")
    @plant_id = new_plant_id
  end

  def update_trait_id(new_trait_id)
    DB.exec("UPDATE plant_traits SET trait_id = ('#{new_trait_id}') WHERE id = ('#{self.id}')")
    @trait_id = new_trait_id
  end
end






