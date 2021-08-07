Rails.application.config.middleware.use OmniAuth::Builder do
  github_keys = Rails.application.credentials[Rails.env.to_sym][:github]
  client_id, client_secret = github_keys&.values_at(:client_id, :client_secret)
  provider :github, client_id, client_secret
end
