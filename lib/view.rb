class View
  def display(recipes) # recipes -- array of Recipe instance
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    print "> "
    return gets.chomp.to_i - 1
  end
end
