require './lib/plant'
require './lib/trait'
require './lib/plant_trait'
require 'pg'

DB = PG.connect(:dbname => 'plant_directory')

def main_menu
  puts "1) Browse all plants to see their traits"
  puts "2) Browse all traits to see which plants have them"
  puts "3) Search for a plant or trait"
  puts "4) Add a new plant to the database"
  puts "5) Add a new trait to the database"
  puts "6) Edit an existing plant or its traits"
  puts "7) Edit an existing trait or the plants associated with it"
  puts "8) Delete an existing plant from the database"
  puts "9) Delete an existing trait from the database"
  puts "x) exit"

  user_input = gets.chomp
  if user_input == "1"
    browse_plants
  elsif user_input == "2"
    browse_traits
  elsif user_input == "3"
    search
  elsif user_input == "4"
    add_plant
  elsif user_input == "5"
    add_trait
  elsif user_input == "6"
    edit_plant
  elsif user_input == "7"
    edit_trait
  elsif user_input == "8"
    delete_plant
  elsif user_input == "9"
    delete_trait
  elsif user_input.to_s == "x"
    puts "goodbye!"
    exit
  else
    puts "sorry, invalid input, try again"
    main_menu
  end
end

def browse_plants
  puts "enter a plant's name to see its traits or enter 'm' to return to the main menu"
  Plant.all do |plant|
    puts plant.name
  end
  user_input = gets.chomp
  Plant.all.each do |plant|
    if plant == user_input
      puts plant + "traits:"
      plant.all_traits
    end
  end
end

def add_plant
  puts "What is the name of the plant?"
  user_input = gets.chomp
  new_plant = Plant.new({:name => user_input})
  new_plant.save
  puts "#{new_plant.name} has been saved to the database"
  main_menu
end

def add_trait
  puts "What is the trait?"
  user_input = gets.chomp
  new_trait = Trait.new({:trait => user_input})
  new_trait.save
  puts "#{new_trait.trait} has been saved to the database"
  main_menu
end

















main_menu
