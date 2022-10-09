require 'rails_helper'

feature 'User can create answer' do

  describe 'Authenticated user' do

    given(:user) { FactoryBot.create(:user) }
    background { sign_in(user) }
    
    given(:question) { FactoryBot.create(:question) }

    scenario 'tries to add new question' do
      visit question_path(question)
      fill_in 'answer[body]', with: 'New answer text'
      click_on 'Add answer'
      expect(page).to have_content 'New answer text'
    end

    scenario 'tries to add new answer with errors' do
      visit question_path(question)
      click_on 'Add answer'
      expect(page).to have_content 'prohibited'
    end
  end

  scenario 'Unauthenticated user tries to add new answer' do
    visit question_path(FactoryBot.create(:question))
    expect(page).to have_no_content 'New answer'
  end
end
