require 'rails_helper'

feature 'User can log out' do
  given(:user) { FactoryBot.create(:user) }

  scenario 'Signed in user tries to log out' do
    sign_in(user)
    expect(page).to have_content 'successfully'

    click_on 'Logout'
    expect(page).to have_content 'successfully'
  end
end
