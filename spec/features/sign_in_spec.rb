require 'rails_helper'

feature 'User can sing in' do
  
  describe 'Authenticated user' do
    given(:user) { FactoryBot.create(:user) }
    background { sign_in(user) }

    scenario 'tries to sign in' do
      # save_and_open_page
      expect(page).to have_content 'successfully'
    end

    scenario 'tries to register' do
      visit new_user_registration_path
      expect(page).to have_content 'already signed in'    
    end
  end

  scenario 'Unregistered user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'unknow@user.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid'
  end
end
