require 'rails_helper'

RSpec.describe "Oauth", type: :request do

  describe "access top page" do
    it "can sign in user with Twitter account" do
      visit '/'
      page.should have_content("Sign in with GitHub")
      mock_auth_hash
      click_link "Sign in"
      page.should have_content("Successfully authenticated from GitHub account.")
    end

    it "can handle authentication error" do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
      visit '/'
      page.should have_content("Sign in with GitHub")
      click_link "Sign in"
      page.should have_content('Authentication failed.')
    end
  end
end