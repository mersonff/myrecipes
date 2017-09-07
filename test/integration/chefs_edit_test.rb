require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
		@chef = Chef.create!(chefname: "Emerson", email:"emerson@example.com",
			               password: "password", password_confirmation: "password")
		@chef2 = Chef.create!(chefname: "john", email: "john@example.com",
                    password: "password", password_confirmation: "password" )
    @admin_user = Chef.create!(chefname: "john", email: "admin@example.com",
                    password: "password", password_confirmation: "password", admin: true )
	end

  test "reject an invalid edit" do
  	sign_in_as(@chef, "password")
  	get edit_chef_path(@chef)
  	assert_template 'chefs/edit'
  	patch chef_path(@chef), params: { chef: { chefname: " ", email: "emerson@example.com"} }
  	assert_template 'chefs/edit'
  	assert_select 'h2.panel-title'
  	assert_select 'div.panel-body'
  end

  test "accept valid edit" do
  	sign_in_as(@chef, "password")
  	get edit_chef_path(@chef)
  	assert_template 'chefs/edit'
  	patch chef_path(@chef), params: { chef: { chefname: "João", email: "emerson@test.com"} }
  	assert_redirected_to @chef
  	assert_not flash.empty?
  	@chef.reload
  	assert_match "João", @chef.chefname
  	assert_match "emerson@test.com", @chef.email
  end

  test "accept edit attempt by admin user" do
  	sign_in_as(@admin_user, "password")
  	get edit_chef_path(@chef)
  	assert_template 'chefs/edit'
  	patch chef_path(@chef), params: { chef: { chefname: "João2", email: "emerson2@test.com"} }
  	assert_redirected_to @chef
  	assert_not flash.empty?
  	@chef.reload
  	assert_match "João2", @chef.chefname
  	assert_match "emerson2@test.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
  	sign_in_as(@chef2, "password")
  	updated_name = "joe"
  	update_email = "joe@example.com"
  	patch chef_path(@chef), params: { chef: { chefname: updated_name, email: update_email} }
  	assert_redirected_to chefs_path
  	assert_not flash.empty?
  	@chef.reload
  	assert_match "Emerson", @chef.chefname
  	assert_match "emerson@example.com", @chef.email
	end

end
