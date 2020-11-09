#bundle exec rspec spec/system/comments_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'Comments Management Function', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:second_user)
    FactoryBot.create(:startup, user: @user)
  end

  describe 'Comments manage' do
    context 'When user login' do
      it 'become followers.' do

        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'Log in'
        visit root_path
        click_on 'show startup'
        fill_in 'comment[content]', with: 'my comment.'
        click_on 'commit'
        expect(page).to have_content 'my comment.'
      end
    end
    context 'When user no login ' do
      it 'can not click on follow button.' do

        visit root_path
        click_on 'show startup'
        fill_in 'comment[content]', with: 'my comment.'
        click_on 'commit'
        expect(page).to have_no_content 'you are not login, please login or create new accompt'
      end
    end
  end
end
