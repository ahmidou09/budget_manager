require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'demo@demo.com', password: '000000')
    category = Category.new(user: user, name: 'Food', icon: 'icon.jpg')
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.new(icon: 'icon.jpg')
    expect(category).to_not be_valid
  end

  it 'is not valid without an icon' do
    category = Category.new(name: 'Food')
    expect(category).to_not be_valid
  end

  it 'has many transfers' do
    category = Category.reflect_on_association(:transfers)
    expect(category.macro).to eq(:has_many)
  end

  it 'requires a unique name' do
    Category.create(name: 'Existing Category', icon: 'icon.jpg')
    new_category = Category.create(name: 'Existing Category', icon: 'icon.jpg')
    expect(new_category).to_not be_valid
  end

  it 'belongs to a user' do
    category = Category.reflect_on_association(:user)
    expect(category.macro).to eq(:belongs_to)
  end
end
