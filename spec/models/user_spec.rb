require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'demo@demo.com', password: '000000')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(email: 'demo@demo.com')
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user = User.new(name: 'John Doe')
    expect(user).to_not be_valid
  end

  it 'has many transfers' do
    user = User.reflect_on_association(:transfers)
    expect(user.macro).to eq(:has_many)
  end

  it 'requires a unique icon' do
    User.create(name: 'existing User', email: 'existg@demo.com')
    new_user = User.new(name: 'New User', email: 'existg@demo.com')
    expect(new_user).to_not be_valid
  end

  it 'password must have at least 6 characters' do
    user = User.new(name: 'John Doe', email: 'demo@demo.com', password: '12345')
    expect(user).to_not be_valid
  end
end
