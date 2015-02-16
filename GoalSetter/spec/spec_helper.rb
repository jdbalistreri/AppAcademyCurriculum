# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end


end


def sign_up(username, password)
  visit new_user_url
  fill_in('Username', with: username)
  fill_in('Password', with: password)
  click_button('Submit')
end

def log_in(username, password)
  visit new_session_url
  fill_in('Username', with: username)
  fill_in('Password', with: password)
  click_button('Submit')
end

def log_out()
  click_button('Log Out')
end

def create_goal(public)
  visit new_goal_url
  fill_in('Title', with: "Mow the lawn")
  fill_in('Description', with: "The grass is really tall.")
  public ? check('Public') : check('Private')
  click_button('Submit')
end

def edit_goal(public)
  click_link("Edit Goal")
  fill_in('Title', with: "Cut the grass")
  fill_in('Description', with: "With a pair of scissors.")
  public ? check('Public') : check('Private')
  click_button('Submit')
end
