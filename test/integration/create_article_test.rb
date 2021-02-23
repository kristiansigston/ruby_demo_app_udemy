require 'test_helper'

class CreateArticeTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create( username:'Johnny Doe',
                              email: 'johnnydoe@example.com',
                              password: 'password',
                              admin: true)
    sign_in_as(@admin_user)
  end
  
  test 'get new article form and create article' do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'The very best title', category: 'category', description: 'A description of the very best  description' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'The very best title', response.body
  end

  test 'get new article from and reject invalid article submission' do
    get '/articles/new'
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: 'The very best title',
        category: 'title', description: '' } }
    end
    
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
