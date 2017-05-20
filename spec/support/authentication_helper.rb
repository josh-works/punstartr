module AuthenticationHelper
  def signup_new_user(user)
    visit signup_path
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password_confirmation
    click_on "Create account"
  end
end
