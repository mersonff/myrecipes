require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  def setup
  	@ingredient = Ingredient.create!(name: "chicken")
  	@ingredient2 = Ingredient.create!(name: "egg")
  	@ingredient3 = Ingredient.create!(name: "oil")
  	@chef = Chef.create!(chefname: "Emerson", email: "emerson@example.com", password:"password", 
  												password_confirmation: "password")
  	@recipe = Recipe.create!(name: "Fried Chicken", description: "This is a recipe for fried chicken", chef: @chef)
  end

  test "should add ingredient to recipe" do
  	assert_difference @recipe.ingredients, 1 do
  		@recipe.ingredients << @ingredient
  	end
  end

  test "should return ingredients of a recipe" do
  	@recipe.ingredients << @ingredient
  	@recipe.ingredients << @ingredient2
  	@recipe.ingredients << @ingredient3
  	assert_includes @recipe.ingredients, @ingredient
  	assert_includes @recipe.ingredients, @ingredient2
  	assert_includes @recipe.ingredients, @ingredient3
  end
end
