require 'pg'
require './lib/plant'
require './lib/trait'
require './lib/plant_trait'
require 'rspec'
# require 'pry'

DB = PG.connect({:dbname => "plant_directory_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM plants *;")
    DB.exec("DELETE FROM traits *;")
    DB.exec("DELETE FROM plant_traits *;")
  end
end



