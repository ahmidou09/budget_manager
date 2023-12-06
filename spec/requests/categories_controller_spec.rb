require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /categories' do
    before do
      @user = User.find_or_create_by(name: 'John', email: 'demo@demo.com') do |user|
        user.password = '000000'
      end
      @category = Category.find_or_create_by(user: @user, name: 'Food') do |category|
        category.icon = 'Food.png'
      end
      sign_in @user
    end

    it 'renders the categories/index view' do
      get categories_path
      expect(response).to have_http_status(:success)
    end

    it 'renders a list with the categories of the user' do
      get categories_path
      expect(response.body).to include('Food')
    end

    it 'renders a button to add a new category' do
      get categories_path
      expect(response.body).to include('Add a New Category')
    end

    it 'clicks on the add a new category button to create a new one' do
      get categories_path
      expect(response.body).to include('Add a New Category')
      get new_category_path
      expect(response).to have_http_status(:success)
    end

    it 'clicks on the logout button to exit from the application' do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
