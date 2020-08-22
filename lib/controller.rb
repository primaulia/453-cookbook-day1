require_relative "view"
require_relative "recipe"
require_relative "scraper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scraper = Scraper.new('https://www.bbcgoodfood.com')
  end

  # ACTIONS UTILISATEURS

  def list
    display_tasks
  end

  def create
    # 1. Ask user for a name (view)
    name = @view.ask_user_for("name")
    # 2. Ask user for a description (view)
    description = @view.ask_user_for("description")
    # 3. Create recipe (model)
    recipe = Recipe.new(name, description)
    # 4. Store in cookbook (repo)
    @cookbook.add(recipe)
    # 5. Display
    display_tasks
  end

  def destroy
    # 1. Display recipes
    display_tasks
    # 2. Ask user for index (view)
    index = @view.ask_user_for_index
    # 3. Remove from cookbook (repo)
    @cookbook.remove_at(index)
    # 4. Display
    display_tasks
  end

  def import
    # view ask for ingredient
    keyword = @view.ask_user_for('ingredient')
    # use the keyword to scrape BBC
    results = @scraper.call(keyword)
    # create an instance of each results
    all_recipes = results.map do |hash|
      # create an instance of recipe
      Recipe.new(hash)
    end

    # pass the view an array of recipe instances
    @view.display(all_recipes)

    # ask user which one i want to import
    imported_index = @view.ask_user_for_index

    imported_recipe = all_recipes[imported_index]
    # add it to the cookbook
    @cookbook.add(imported_recipe)


  end

  private

  def display_tasks
    # 1. Get recipes (repo)
    recipes = @cookbook.all
    # 2. Display recipes in the terminal (view)
    @view.display(recipes)
  end
end
