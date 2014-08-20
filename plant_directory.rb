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
  Plant.all.each do |plant|
    puts plant.name
  end
  user_input = gets.chomp
  Plant.all.each do |plant|
    if user_input == 'm'
      main_menu
    elsif user_input == plant.name
      puts "#{plant.name} traits:"
      plant.all_traits.each do |trait|
        puts trait.trait
      end
    end
  end
  main_menu
end

def browse_traits
  puts "enter the trait you'd like to look more closely at or enter 'm' to return to the main menu"
  Trait.all.each do |trait|
    puts trait.trait
  end
  user_input = gets.chomp
  Trait.all.each do |trait|
    if user_input == 'm'
      main_menu
    elsif user_input == trait
      puts trait + "is a trait of these plants:"
      trait.all_plants
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

def edit_plant
  puts "Which plant do you want to edit?"
  Plant.all.each do |plant|
    puts plant.name
  end
  plant_input = gets.chomp
  plant_counter = 0
  Plant.all.each do |plant|
    if plant_input == plant.name
      @selected_plant = plant
      plant_counter += 1
    end
  end
  if plant_counter == 0
    puts "invalid input, try again"
    edit_plant
  end
  puts "What do you want to do with #{plant_input}?"
  puts "1) edit plant name"
  puts "2) add traits"
  puts "3) remove traits"
  menu_input = gets.chomp
  if menu_input == "1"
    puts "Enter the plant's new name:"
    new_name = gets.chomp
    @selected_plant.update(new_name)
    main_menu
  elsif menu_input == "2"
    puts "Which trait would you like to add to this plant?"
    Trait.all.each_with_index do |trait, index|
      puts "#{index + 1}) #{trait.trait}"
    end
    puts "Enter 'm' to return to main menu"
    user_input = gets.chomp
    if user_input == 'm'
      main_menu
    end
    Trait.all.each_with_index do |trait, index|
      if index == (user_input.to_i - 1)
        @selected_trait = trait
      end
    end
    new_association = Plant_Trait.new({:plant_id => @selected_plant.id, :trait_id => @selected_trait.id})
    new_association.save
    main_menu
  elsif menu_input == "3"
    puts "Which trait would you like to remove from this plant?"
    @selected_plant.all_traits.each_with_index do |trait, index|
        puts "#{index+1}) #{trait.trait}"
    end
    user_input = gets.chomp
    @selected_plant.all_traits.each_with_index do |trait, index|
      if index == (user_input.to_i - 1)
        DB.exec("DELETE FROM plant_traits WHERE trait_id = (#{trait.id}) AND plant_id = (#{@selected_plant.id})")
      end
    end
    main_menu
  end
end















main_menu
