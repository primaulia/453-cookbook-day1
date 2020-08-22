require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run


# TODO:
# Ask a user for a keyword to search => View
# Make an HTTP request to the recipe’s website with our keyword => Controller (Scraping)
  # We scrape HTML -> parse (Nokogiri) -> Nokogiri instance, #search () -> array of strings -> Array of Recipe instance 
# Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
# Display them in an indexed list => View#display --> Array of Recipe instance
# Ask the user which recipe they want to import (ask for an index) --> View#ask_user_for_index
# Add it to the Cookbook