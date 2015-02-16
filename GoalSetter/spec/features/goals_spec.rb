require 'spec_helper'
require 'rails_helper'



feature 'create goals' do
  before :each do
    sign_up('kittykat', 'password')
  end

  scenario 'has a create goals page' do
    visit new_goal_url
    expect(page).to have_content "New Goal"
  end

  feature 'creates a goal' do

    scenario "redirects to user's goal page on creation" do
      create_goal(true)
      expect(page).to have_content "Mow the lawn"
    end

    scenario "redirects to login when not logged in" do
      log_out
      visit new_goal_url
      expect(page).to have_content "Log In"
    end

  end
end


feature 'shows user goals' do
  before :each do
    sign_up("kittykat", "password")
    create_goal(true)
  end

  scenario "shows list of links to user goals"
    click_link('Mow the lawn')
    expect(page).to have_content('Mow the lawn')

end



feature 'update goals' do


end


feature 'delete goals' do


end
