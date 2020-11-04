#bundle exec rspec spec/system/user_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'User registration, login and logout functions', type: :system do
    user = FactoryBot.create(:user)
  describe 'Testing User Registration' do
    context 'If the user has no data and is not logged in' do
      it 'Testing New User Registration' do
        visit  new_user_registration_path
        fill_in 'user[name]', with: 'user2'
        fill_in 'user[email]', with: 'user2@gmail.com'
        fill_in 'user[password]', with: '000000'
        fill_in 'user[password_confirmation]', with: '000000'
        click_button 'Sign up'
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      end
      it 'get error if register the same email address for 2 users' do
        visit  new_user_registration_path
        fill_in 'user[name]', with: 'user2'
        fill_in 'user[email]', with: 'user2@gmail.com'
        fill_in 'user[password]', with: '000000'
        fill_in 'user[password_confirmation]', with: '000000'
        click_button 'Sign up'

       visit new_user_registration_path
       fill_in 'user[name]', with: 'user'
       fill_in 'user[email]', with: 'user2@gmail.com'
       fill_in 'user[password]', with: '000000'
       fill_in 'user[password_confirmation]', with: '000000'
       click_button 'Sign up'
       expect { raise StandardError, 'Email has already been taken'}.to raise_error('Email has already been taken')
     end
     it 'get error if register the same name address for 2 users' do
       visit  new_user_registration_path
       fill_in 'user[name]', with: 'user2'
       fill_in 'user[email]', with: 'user2@gmail.com'
       fill_in 'user[password]', with: '000000'
       fill_in 'user[password_confirmation]', with: '000000'
       click_button 'Sign up'

      visit new_user_registration_path
      fill_in 'user[name]', with: 'user2'
      fill_in 'user[email]', with: 'user@gmail.com'
      fill_in 'user[password]', with: '000000'
      fill_in 'user[password_confirmation]', with: '000000'
      click_button 'Sign up'
      expect { raise StandardError, 'Name has already been taken'}.to raise_error('Name has already been taken')
    end
    it 'get error if register without name' do
      visit  new_user_registration_path
      fill_in 'user[email]', with: 'user2@gmail.com'
      fill_in 'user[password]', with: '000000'
      fill_in 'user[password_confirmation]', with: '000000'
      click_button 'Sign up'
      expect { raise StandardError, "Name can't be blank"}.to raise_error("Name can't be blank")
    end
    it 'get error if register without password' do
      visit  new_user_registration_path
      fill_in 'user[name]', with: 'user2'
      fill_in 'user[email]', with: 'user2@gmail.com'
      click_button 'Sign up'
     expect { raise StandardError, "Password can't be blank"}.to raise_error("Password can't be blank")
   end
  end
end
  describe 'Testing the Session Functionality' do
    context 'If the user has no data and is not logged in' do
      it 'Testing Session Logins' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
      it 'Test to jump to the new startup path screen when you are not logged in' do
        visit new_startup_path
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
    context 'If the user is logged in' do
      it 'Testing Session Logouts' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        #click_link 'logout'
        click_link 'logout'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Signed out successfully.'
      end
      it 'When user are logged can not go to user registration screen' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit new_user_session_path
        expect(current_path).to eq root_path
        expect(page).to have_content 'You are already signed in.'
      end
    end
  end

end
