require 'rails_helper'

feature 'User can get questions list' do
    
    scenario 'Authenticated user' do
      sign_in(FactoryBot.create(:user))
      visit questions_path
      expect(page).to have_content 'Questions'
    end
    
    scenario 'Guest' do
      visit questions_path
      expect(page).to have_content 'Questions'
    end
end
