require 'rails_helper'

feature 'User can question' do
  
  given(:question) { FactoryBot.create(:question) }

  describe 'Authenticated user' do

    scenario 'tries to delete his own question' do
      sign_in(question.author)
      page.driver.submit(:delete, question_path(question), {})
      expect(page).to have_content 'successfully'
    end

    scenario 'tries to delete question' do
      sign_in( FactoryBot.create(:user))
      Capybara::RackTest::Browser.submit(:delete, question_path(question))
      expect(page).to have_content 'denied'
    end
  end

  scenario 'Unauthenticated tries to delete question' do
    Capybara::RackTest::Browser.submit(:delete, question_path(question))
    expect(page).to have_content 'denied'
  end
end
