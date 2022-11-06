require 'rails_helper'

feature 'User can edit answer' do

  given!(:user) { FactoryBot.create(:user) }
  given!(:question) { FactoryBot.create(:question) }
  given!(:answer) { FactoryBot.create(:answer, question: question, author: user) }

  scenario 'Unauthenticated user tries to edit answer' do
    visit question_path(FactoryBot.create(:question))
    expect(page).to_not have_link 'Edit'
  end
  
  describe 'Authenticated user', js: true, driver: :selenium_chrome_headless do
    background { sign_in(user) }

    given(:question) { FactoryBot.create(:question) }

    scenario 'tries to edit own answer', js: true do
      visit question_path(question)
      click_on "Edit"
      within ".answers" do
        fill_in "Body", with: "edited answer"
        click_on "Save"
        expect(page).to_not have_content answer.body
        expect(page).to have_content "edited answer"
        expect(page).to_not have_selector "textarea"
      end 
    end

    scenario 'tries to edit own answer with errors', js: true do
      visit question_path(question)
      click_on "Edit"
      within ".answers" do
        fill_in "Body", with: ""
        click_on "Save"
        expect(page).to have_content 'prohibited'
        expect(page).to have answer.body
        expect(page).to have_selector "textarea"
      end 
    end
  end

end
