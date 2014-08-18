class Trait
  attr_reader(:trait, :attributes)

  def initialize(attributes)
    @attributes = attributes
    @traits = attributes[:trait]
  end

end
