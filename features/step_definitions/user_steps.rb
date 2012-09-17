# See notes in 'Given /^I am not signed in$/
World(Rack::Test::Methods)

Given /^I am not signed in$/ do
  # Can't just 'visit "user/sign_out"' because in Rails 3 + Devise 2 the sign out
  # route uses the DELETE action instead of GET.  So use the delete method from 
  # Rack::Test::Methods
  delete "/users/sign_out"
end

Given /^I am signed in as "(.*)\/(.*)"$/ do |email, password|
  @user = User.create!({ 
                         :email => email,
                         :password => password,
                         :password_confirmation => password
                       })
  visit "/users/sign_in"
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
  click_button "Sign in"
end
