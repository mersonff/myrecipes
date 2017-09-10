require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  def setup
  	@ingredient = Ingredient.create!(name: "chicken")
  	@ingredient2 = Ingredient.create!(name: "egg")
  end

  test "ingredient should be valid" do
		assert @ingredient.valid?
	end

	test "ingredient name should be unique" do
		@ingredient3 = Ingredient.new(name: "chicken")
		assert_not @ingredient3.valid?
	end

	test "ingredient name should be present" do
		@ingredient.name = " "
		assert_not @ingredient.valid?
	end

	test "ingredient shouldn't be more than 2 characters" do
		@ingredient.name = "aa" 
		assert_not @ingredient.valid?
	end
end
