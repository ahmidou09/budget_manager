require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it 'is valid with valid attributes' do
    user = User.create!(name: 'John Doe', email: 'demo@demo.com', password: '000000')
    category = Category.create!(user: user, name: 'Food', icon: 'icon.jpg')
    transfer = Transfer.new(user: user, name: 'Taco', amount: 7.5, category: category)
    expect(transfer).to be_valid
  end

  it 'is not valid without a user' do
    transfer = Transfer.new(name: 'Taco', amount: 7.5, category_id: 1)
    expect(transfer).to_not be_valid
  end

  it 'is valid with valid attributes and associated category' do
    user = User.create!(name: 'John Doe', email: 'demo@demo.com', password: '000000')
    category = Category.create!(user: user, name: 'Food', icon: 'icon.jpg')
    transfer = Transfer.new(user: user, name: 'Taco', amount: 7.5, category: category)
    expect(transfer).to be_valid
  end

  it 'is not valid without a category' do
    user = User.create!(name: 'John Doe', email: 'demo@demo.com', password: '000000')
    transfer = Transfer.new(user: user, name: 'Taco', amount: 7.5)
    expect(transfer).to_not be_valid
  end

  it 'has and belongs to a user' do
    transfer = Transfer.reflect_on_association(:user)
    expect(transfer.macro).to eq(:belongs_to)
  end

  it 'belongs to a category' do
    transfer = Transfer.reflect_on_association(:category)
    expect(transfer.macro).to eq(:belongs_to)
  end
end
