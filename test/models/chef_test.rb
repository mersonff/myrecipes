require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "Emerson", email:"emerson@example.com",
			               password: "password", password_confirmation: "password")
	end

	test "chef should be valid" do
		assert @chef.valid?
	end

	test "chefname should be valid" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname shouldn't be more than 30 characters" do
		@chef.chefname = "a" * 31
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email shouldn't be to long" do
		@chef.email = "a" * 245 + "@example.com"
		assert_not @chef.valid?
	end

	test "email should be correct format" do
		valid_emails = %w[user@example.com MASHUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
		valid_emails.each do |valids| 
			@chef.email = valids
			assert @chef.valid?, "#{valids.inspect} should be valid"
		end
	end

	test "should reject invalid addresses" do
		invalid_emails = %w[emerson@example emerson@example,com mashrur.tim@gmail. joe@bar+foo.com]
		invalid_emails.each do |invalids|
			@chef.email = invalids
			assert_not @chef.valid?, "#{invalids.inspect} should be valid"
		end 
	end

	test "email should be unique and case insensitive" do
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not duplicate_chef.valid?
	end

	test "email should be lowercase before hitting db" do
		mixed_email = "JoHn@Example.com"
		@chef.email = mixed_email
		@chef.save
		assert_equal mixed_email.downcase, @chef.reload.email
	end

	test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be atleast 5 character" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end