require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Splash Page', type: :feature do
  describe 'User clicks on Log In button' do
    it 'is redirected to the login page' do
      visit root_path

      within('.box-button') do
        click_link 'Log In'
      end

      expect(page).to have_current_path(new_user_session_path)
    end
  end

  describe 'User clicks on Sign Up button' do
    it 'is redirected to the registration page' do
      visit root_path

      within('.box-button') do
        click_link 'Sign Up'
      end

      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  describe 'Page content' do
    it 'displays the correct title' do
      visit root_path

      expect(page).to have_content('Budget Manager')
    end
  end
end
