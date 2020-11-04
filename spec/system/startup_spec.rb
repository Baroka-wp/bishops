#bundle exec rspec spec/system/startup_spec.rb

require 'rails_helper'
require 'selenium-webdriver'
require 'capybara'

RSpec.describe 'startup Management Function', type: :system do
  user = FactoryBot.create(:user)
  user2 = FactoryBot.create(:second_user)

  describe 'startup registration screen' do
    context 'When you fill in the required fields and press the create button' do
      it 'Data is stored.' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit new_startup_path
        fill_in 'startup[name]', with: "startup2"
        fill_in 'startup[contact]', with: '67153974'
        fill_in 'startup[trade_registre]', with:'12003654879'
        fill_in 'startup[adresse]', with: '22 rue benin'
        fill_in 'startup[video]', with: 'https://www.youtube.com/watch?v=sQR2-Q-k_9Y'
        fill_in 'startup[resume]', with: 'Sed ut perspiciatis unde
          omnis iste natus error sit voluptatem
          accusantium doloremque laudantium,
          totam rem aperiam, eaque ipsa quae ab illo
          inventore veritatis et quasi architecto beatae
          vitae dicta sunt explicabo. Nemo enim ipsam
          voluptatem quia voluptas sit aspernatur aut
          odit aut fugit, sed quia consequuntur magni
          dolores eos qui ratione voluptatem sequi nesciunt.'
        select 'it', from: 'startup[sector_of_business]'
        click_on 'commit'
        expect(page).to have_content 'startup2'
      end
    end
    context 'when user fill wrong field' do
      it 'can not create startup without name, resume, adresse, sector_of_business, contact' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit new_startup_path
        fill_in 'startup[trade_registre]', with:'12003654879'
        fill_in 'startup[video]', with: 'https://www.youtube.com/watch?v=sQR2-Q-k_9Y'
        click_on 'commit'
        expect { raise StandardError, "Name can't be blank"}.to raise_error("Name can't be blank")
        expect { raise StandardError, "Resume can't be blank"}.to raise_error("Resume can't be blank")
        expect { raise StandardError, "Adresse can't be blank"}.to raise_error("Adresse can't be blank")
        expect { raise StandardError, "Sector_of_business can't be blank"}.to raise_error("Sector_of_business can't be blank")
        expect { raise StandardError, "Contact can't be blank"}.to raise_error("Contact can't be blank")
      end
    end
    context 'when user had startup' do
      it 'can not create anather startup' do
        FactoryBot.create(:startup, user: user)
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit new_startup_path
        expect { raise StandardError, 'you have a startup on Bishop'}.to raise_error('you have a startup on Bishop')
      end
      it 'can not create startup with same name' do
        FactoryBot.create(:startup, user: user)
        visit new_user_session_path
        fill_in 'user[email]', with: user2.email
        fill_in 'user[password]', with: user2.password
        click_button 'Log in'
        visit new_startup_path
        fill_in 'startup[name]', with: "startup1"
        fill_in 'startup[contact]', with: '67153974'
        fill_in 'startup[trade_registre]', with:'12003654879'
        fill_in 'startup[adresse]', with: '22 rue benin'
        fill_in 'startup[video]', with: 'https://www.youtube.com/watch?v=sQR2-Q-k_9Y'
        fill_in 'startup[resume]', with: 'Sed ut perspiciatis unde
          omnis iste natus error sit voluptatem
          accusantium doloremque laudantium,
          totam rem aperiam, eaque ipsa quae ab illo
          inventore veritatis et quasi architecto beatae
          vitae dicta sunt explicabo. Nemo enim ipsam
          voluptatem quia voluptas sit aspernatur aut
          odit aut fugit, sed quia consequuntur magni
          dolores eos qui ratione voluptatem sequi nesciunt.'
        select 'it', from: 'startup[sector_of_business]'
        click_on 'commit'
        expect { raise StandardError, 'Name has already been taken'}.to raise_error('Name has already been taken')
      end
    end
  end
    describe 'search function' do
      context 'If user search by name' do
        it 'You can search by name.' do
          FactoryBot.create(:startup, user: user)
          visit new_user_session_path
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_button 'Log in'
          fill_in "name", with: 'sta'
          click_button 'search'
          expect(page).to have_content 'startup1'
        end
      end
    end
end
