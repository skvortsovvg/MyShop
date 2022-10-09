require 'rails_helper'

feature 'User can sing up' do

  background { visit new_user_registration_path }

  scenario 'New user tries to register' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'test123'
    fill_in 'Password confirmation', with: 'test123'

    click_on 'Sign up'

    expect(page).to have_content 'successfully'
  end

  given(:user) { FactoryBot.create(:user) }

  scenario 'Exsisting user tries to register' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'already been taken'
  end
 
end
