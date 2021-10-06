module LoginHelpers
  def auth0_login
    # this will create the user with the uid in mock_auth
    visit '/auth/auth0/callback'
  end

  def mock_auth0_login
    allow_any_instance_of(UserHelpers).to receive(:current_user).and_return(user)
    allow_any_instance_of(UserHelpers).to receive(:logged_in?).and_return(true)
  end
end
