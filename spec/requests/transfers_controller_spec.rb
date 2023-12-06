require 'rails_helper'

RSpec.describe 'TransfersControllers', type: :request do
  before do
    @user = User.find_or_create_by(name: 'John deo', email: 'demo@demo.com') do |user|
      user.password = '000000'
    end
    @category = Category.find_or_create_by(user: @user, name: 'Food') do |category|
      category.icon = 'Food.png'
    end

    sign_in @user
  end

  describe 'GET #new' do
    it 'renders the add a new transfer page' do
      get new_category_transfer_path(@category)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new transaction' do
      post category_transfers_path(@category), params: { transfer: { name: 'Taco', amount: 9.00 } }
      expect(response).to redirect_to(category_path(@category))
    end
  end
end
