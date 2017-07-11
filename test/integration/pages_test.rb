require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  
  test "deve retornar homepage" do 
  	get pages_home_url
  	assert_response :success
  end

  test "deve retornar root" do 
  	get root_url
  	assert_response :success
  end
end
