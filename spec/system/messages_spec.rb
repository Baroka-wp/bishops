#bundle exec rspec spec/system/messages_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'messages Management Function', type: :system do
  user = FactoryBot.create(:user)
  user2 = FactoryBot.create(:second_user)

  describe 'message manage' do
    context 'When user login' do
      it 'can send messages.' do

        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'

        visit user_path(user2.id)
        click_on 'send message'
        fill_in 'message[body]', with: 'my message.'
        click_on 'commit'
        expect(page).to have_content 'my message.'
      end
    end
    context 'When user no login ' do
      it 'can not send message.' do
        visit user_path(user2.id)
        expect(page).to have_no_content 'send message'
      end
    end
  end
end
