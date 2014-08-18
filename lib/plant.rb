class Plant
  attr_reader(:attributes, :name, :traits, :id)

  def initialize(attributes)
    @attributes = attributes
    @name = attributes[:name]
    @traits = attributes[:traits]
    @id = attributes[:id]
  end

  def save
    DB.exec("INSERT INTO plants (plant_name) VALUES ('#{@name}')")
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

  # def ==(another_plant)

  # end

end
