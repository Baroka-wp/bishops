#bundle exec rspec spec/system/user_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'User registration, login and logout functions', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'Testing User Registration' do
    context 'If the user has no data and is not logged in' do
      it 'Testing New User Registration' do
        visit  new_user_registration_path
        fill_in 'user[name]', with: 'user2'
        fill_in 'user[email]', with: 'user2@gmail.com'
        fill_in 'user[password]', with: '000000'
        fill_in 'user[password_confirmation]', with: '000000'
        click_button 'Create User'
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      end
    end
  end
  describe 'Testing the Session Functionality' do
    context 'If the user has no data and is not logged in' do
      it 'Testing Session Logins' do
        visit new_user_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
    end
    context 'If the user is logged in' do
      it 'Testing Session Logouts' do
        visit new_user_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_button 'Log in'
        #click_link 'logout'
        click_on_button 'logout'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
      end
    end
  end

end
