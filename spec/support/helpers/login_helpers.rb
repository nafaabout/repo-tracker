module LoginHelpers
  def auth0_login
    # this will create the user with the uid in mock_auth
    visit '/auth/auth0/callback'
  end
end
