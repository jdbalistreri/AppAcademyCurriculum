require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up("kitty_cat", "password")
      expect(page).to have_content "kitty_cat"
      expect(page).to have_content "Users"
    end
  end
end

feature "logging in" do

  scenario "has a log-in page" do
    visit new_session_url
    expect(page).to have_content "Log In"
  end

  scenario "shows username, all users, and log out button on the homepage after login" do
    sign_up("kitty_cat", "password")
    log_in("kitty_cat", "password")
    expect(page).to have_content "kitty_cat"
    expect(page).to have_content "Users"
    expect(page).to have_content "Log Out"
  end

end

feature "logging out" do

  scenario "begins with logged out state" do
    visit users_url
    expect(page).to have_content "Log In"
    expect(page).not_to have_content "Log Out"
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up("kitty_kat", "password")
    log_out
    expect(page).not_to have_content "kitty_kat"
    expect(page).to have_content "Log In"
  end

end
