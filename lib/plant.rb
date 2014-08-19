require 'pg'

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

end
