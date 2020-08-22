class Recipe
  attr_reader :name, :description

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
  end
end


# Now your model can expect multiple attributes and minimal attributes
# as given

# slushie = Recipe.new({
#   name: 'Strawberry Slushie',
#   description: 'The description'
# })

# pp slushie