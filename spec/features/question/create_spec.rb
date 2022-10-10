require 'rails_helper'

feature 'User can create question' do
  describe 'Authenticated user' do
    background { sign_in(FactoryBot.create(:user)) }

    scenario 'tries to add new question' do
      visit new_question_path
      expect(page).to have_content 'New Question'

      fill_in 'Title', with: 'New test question'
      fill_in 'Body', with: 'Texttextext'
      click_on 'Create'

      expect(page).to have_content 'Questions'
      expect(page).to have_content 'New test question'
      expect(page).to have_content 'Texttextext'
    end

    scenario 'tries to add new question with errors' do
      visit new_question_path
      click_on 'Create'

      expect(page).to have_content 'prohibited'
    end
  end

  scenario 'Unauthenticated user tries to add new question' do
    visit new_question_path
    expect(page).to have_content 'need to sign in'
  end
end
