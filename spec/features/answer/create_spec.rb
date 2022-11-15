require 'rails_helper'

feature 'User can create answer' do
  describe 'Authenticated user' do
    given(:user) { FactoryBot.create(:user) }
    background { sign_in(user) }

    given(:question) { FactoryBot.create(:question) }

    scenario 'tries to add new answer' do
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

    scenario 'add new answer with attached files', js: true do
      visit new_question_path
      fill_in 'answer[body]', with: 'New answer text'
      attach_file "answer[files][]", ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Add answer'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to add new answer' do
    visit question_path(FactoryBot.create(:question))
    expect(page).to have_no_content 'New answer'
  end
end
