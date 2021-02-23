require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest
  
  test 'create user' do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username:'Johnny Doe',
        email: 'johnnydoe@example.com',
        password: 'password' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'Johnny Doe', response.body
  end

  test 'reject user sign up' do
    get '/signup'
    assert_response :success
    assert_no_difference 'Article.count' do
      post users_path, params: { user: {username:'',
        email: 'johnnydoe@example.com',
        password: 'password' }}
    end
    
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end

