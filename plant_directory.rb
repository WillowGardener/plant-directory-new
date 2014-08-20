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
    elsif user_input == trait.trait
      puts "#{trait.trait} is a trait of these plants:"
      trait.all_plants.each do |plant|
        puts plant.name
      end
    end
  end
  main_menu
end

def search
  puts "Enter the plant or trait you'd like to find"
  search_term = gets.chomp
  Plant.all.each do |plant|
    if plant.name == search_term
      puts "yup, that's a plant!"
    end
  end
  Trait.all.each do |trait|
    if trait.trait == search_term
      puts "yup, that's a trait!"
    end
  end
  main_menu
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

def edit_trait
  puts "Which trait do you want to edit?"
  Trait.all.each do |trait|
    puts trait.trait
  end
  trait_input = gets.chomp
  trait_counter = 0
  Trait.all.each do |trait|
    if trait_input == trait.name
      @selected_trait = trait
      trait_counter += 1
    end
  end
  if trait_counter == 0
    puts "invalid input, try again"
    edit_trait
  end
  puts "What do you want to do with #{trait_input}?"
  puts "1) edit trait name"
  puts "2) add plant association"
  puts "3) remove plant association"
  menu_input = gets.chomp
  if menu_input == "1"
    puts "Enter the trait's new name:"
    new_name = gets.chomp
    @selected_trait.update(new_name)
    main_menu
  elsif menu_input == "2"
    puts "Which plant would you like to associate with this plant?"
    Plant.all.each_with_index do |plant, index|
      puts "#{index + 1}) #{plant.name}"
    end
    puts "Enter 'm' to return to main menu"
    user_input = gets.chomp
    if user_input == 'm'
      main_menu
    end
    Plant.all.each_with_index do |plant, index|
      if index == (user_input.to_i - 1)
        @selected_plant = plant
      end
    end
    new_association = Plant_Trait.new({:plant_id => @selected_plant.id, :trait_id => @selected_trait.id})
    new_association.save
    main_menu
  elsif menu_input == "3"
    puts "Which plant association would you like to remove from this trait?"
    @selected_trait.all_plants.each_with_index do |plant, index|
        puts "#{index+1}) #{plant.name}"
    end
    user_input = gets.chomp
    @selected_trait.all_plants.each_with_index do |plant, index|
      if index == (user_input.to_i - 1)
        DB.exec("DELETE FROM plant_traits WHERE trait_id = (#{plant.id}) AND plant_id = (#{@selected_trait.id})")
      end
    end
    main_menu
  end
end

def delete_plant
  puts "Which plant is no longer worthy of the database?"
  Plant.all.each do |plant|
    puts plant.name
  end
  user_input = gets.chomp
  Plant.all.each do |plant|
    if plant.name == user_input
      @doomed = plant.name
      plant.delete
    end
  end
  puts "#{@doomed} has been deleted from the database"
  main_menu
end

def delete_trait
  puts "Which trait is no longer worthy of the database?"
  Trait.all.each do |trait|
    puts trait.name
  end
  user_input = gets.chomp
  Trait.all.each do |trait|
    if trait.trait == user_input
    @doomed = trait.name
    trait.delete
    end
  end
  puts "#{@doomed} has been deleted from the database"
  main_menu
end














main_menu
