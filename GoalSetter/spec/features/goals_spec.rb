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

  feature 'creates and shows a new goal' do

    scenario "redirects to the new goal page on creation" do
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
    create_goal(false)
  end

  scenario 'does not show private user goals' do
    goal = Goal.first
    log_out
    sign_up('mrchucklez', 'password')
    click_link('kittykat')
    expect(page).not_to have_content('Mow the lawn')
    visit(goal_url(goal.id))
    expect(page).to have_content('You cannot see private goals')
  end

  scenario 'has an all public goals page' do
    click_link("All Goals")
    expect(page).to have_content("All Goals")
  end
end



feature 'update goals' do
  before :each do
    sign_up("kittykat", "password")
    create_goal(true)
  end

  scenario 'goal page shows a link to edit goal' do
    expect(page).to have_content("Edit Goal")
  end

  scenario 'cannot edit another user goal' do
    log_out
    sign_up('mrchucklez', 'password')
    goal = Goal.first
    click_link('kittycat')
    click_link('Mow the lawn')
    expect(page).not_to have_content("Edit Goal")
    visit(edit_goal_url(goal.id))
    expect(page).to have_content("Cannot edit another user's goals")
  end

  scenario "user can update their goals" do
    edit_goal(true)
    expect(page).to have_content("Cut the grass")
  end
end


feature 'delete goals' do
  before :each do
    sign_up("kittykat", "password")
    create_goal(true)
  end

  scenario 'goal page shows a link to delete goal' do
    expect(page).to have_content("Delete Goal")
  end

  scenario 'cannot delete another user goal' do
    log_out
    sign_up('mrchucklez', 'password')
    goal = Goal.first
    click_link('kittycat')
    click_link('Mow the lawn')
    expect(page).not_to have_content("Delete Goal")
  end

  scenario "user can delete their goals" do
    click_button('Delete Goal')
    expect(page).not_to have_content("Mow the lawn")
  end
end
