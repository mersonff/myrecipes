require 'test_helper'

class CommentsTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.create!(chefname: "Emerson", email:"emerson@example.com",
			               password: "password", password_confirmation: "password")
		@recipe = @chef.recipes.create!(name: "vegetable", description: "great vegetable recipe")
		@comment = @recipe.comments.build(description: "Test comment", chef: @chef)
	end
  
  test "comment should be valid" do
		assert @comment.valid?
	end

	test "chef and recipe id should be present" do
		@comment.chef_id = nil
		@comment.recipe_id = nil 
		assert_not @comment.valid?
	end

	test "ingredient shouldn't be less than 4 characters" do
		@comment.description = "aa" 
		assert_not @comment.valid?
	end

end
