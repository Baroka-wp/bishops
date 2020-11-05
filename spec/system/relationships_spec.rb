#bundle exec rspec spec/system/relationships_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'Relationship Management Function', type: :system do
  user = FactoryBot.create(:user)
  user2 = FactoryBot.create(:second_user)

  describe 'relationship manage' do
    context 'When user login click on follow button' do
      it 'become followers.' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit users_path
        click_on 'add to my network'
        expect(page).to have_content 'user2 belong to your network'
      end
    end
    context 'When user no login ' do
      it 'can not click on follow button.' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit users_path
        expect(page).to have_no_content 'add to my network'
      end
    end
  end
end
