require 'rails_helper'

feature 'User can sing in' do

  given(:user) { User.create(email: 'user@test.com', password: '123456') }

  background { visit new_user_session_path }

  scenario 'Registered user tries to sing in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    # save_and_open_page
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Unregistered user tries to sing in' do
    fill_in 'Email', with: 'unknow@user.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid'
  end

end
