require 'rails_helper'

feature 'User can add links to questions' do
  given(:url) {'https://thinknetica.teachbase.ru'}

  scenario 'User add links to new question' do
    sign_in(FactoryBot.create(:user))
    visit new_question_path
    fill_in 'Title', with: 'New test question'
    fill_in 'Body', with: 'Texttextext'
    fill_in 'Link name', with: 'New link'
    fill_in 'Source URL', with: url
    click_on 'Create'

    expect(page).to have_link 'New link', href: url
  end

end