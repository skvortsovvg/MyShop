require 'rails_helper'

feature 'User can get question page with answers' do
  scenario 'Authenticated user' do
    sign_in(FactoryBot.create(:user))
    visit question_path(FactoryBot.create(:question))
    expect(page).to have_content 'Question'
    expect(page).to have_content 'New answer'
  end

  scenario 'Guest' do
    visit question_path(FactoryBot.create(:question))
    expect(page).to have_content 'Question'
  end
end
