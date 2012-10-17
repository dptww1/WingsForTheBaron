# See notes in 'Given /^I am not signed in$/
World(Rack::Test::Methods)

Given /^I am not signed in$/ do
  # Can't just 'visit "user/sign_out"' because in Rails 3 + Devise 2 the sign out
  # route uses the DELETE action instead of GET.  So use the delete method from 
  # Rack::Test::Methods
  delete "/users/sign_out"
end

Given /^I am signed in as "(.*)\/(.*)"$/ do |email, password|
  visit new_user_session_url
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

When /^I register as "(.*)\/(.*)"$/ do |email, password|
  visit new_user_registration_url
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  fill_in "Password confirmation", :with => password
  click_button "Sign up"
end

When /^I am signed in$/ do
  step "I am signed in as \"test1@example.com/test1@example.com\""
end
