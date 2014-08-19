require 'pg'
require 'spec_helper'

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

end
