require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @recipes = [] # <--- <Recipe> instances
    @csv_file = csv_file
    load_csv
  end

  def add(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_at(index)
    @recipes.delete_at(index)
    save_to_csv
  end

  def all
    return @recipes
  end

  private

  def load_csv
    option = {
      headers: true,
      header_converters: :symbol
    }

    CSV.foreach(@csv_file, option) do |row|
      @recipes << Recipe.new(row)
    end
  end

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ['name', 'description']
      @recipes.each do |recipe|
        csv << [ recipe.name, recipe.description ]
      end
    end
  end
end















