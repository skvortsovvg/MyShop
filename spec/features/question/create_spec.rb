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

      expect(page).to have_content 'Question'
      expect(page).to have_content 'New test question'
      expect(page).to have_content 'Texttextext'
    end

    scenario 'tries to add new question with errors' do
      visit new_question_path
      click_on 'Create'

      expect(page).to have_content 'prohibited'
    end

    scenario 'add new question with attached files' do
      visit new_question_path
      fill_in 'Title', with: 'New test question'
      fill_in 'Body', with: 'Texttextext'

      attach_file "Files", ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Create'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to add new question' do
    visit new_question_path
    expect(page).to have_content 'need to sign in'
  end
end
