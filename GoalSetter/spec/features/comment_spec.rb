require 'spec_helper'
require 'rails_helper'

feature 'can comment on users' do
  before :each do
    sign_up("kittykat", "password")
    log_out
    sign_up("mrchucklez", "trouble")
  end

  scenario 'users show page has a comment form' do
    click_link("kittykat")
    expect(page).to have_content("New Comment")
  end

  scenario 'users show page has a comment form' do
    click_link("kittykat")
    fill_in("Comment", with: "my precious kitty")
    click_button('New Comment')
    expect(page).to have_content('my precious kitty')
    expect(page).to have_content('(mrchucklez)')
  end
end

feature 'can comment on goals' do
  before :each do
    sign_up("kittykat", "password")
    create_goal(true)
    log_out
    sign_up("mrchucklez", "trouble")
  end

  scenario 'users show page has a comment form' do
    click_link("kittykat")
    click_link("Mow the grass")
    expect(page).to have_content("New Comment")
  end

  scenario 'users show page has a comment form' do
    click_link("kittykat")
    click_link("Mow the grass")
    fill_in("Comment", with: "my precious kitty")
    click_button('New Comment')
    expect(page).to have_content('my precious kitty')
    expect(page).to have_content('(mrchucklez)')
  end
end
