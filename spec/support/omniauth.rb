OmniAuth.config.test_mode = true
info = {
  'name' => Faker::Name.name,
  'nickname' => Faker::Internet.username,
  'email' => Faker::Internet.email,
  'image' => Faker::Avatar.image
}
OmniAuth.config.mock_auth[:auth0] = {
  'provider' => 'auth0',
  'uid' => ['github', Faker::Number.number].join('|'),
  'info' => info,
  'credentials' => {
    'token' => Faker::Internet.uuid,
    'expires_at' => 1.day.since.to_i,
    'expires' => true,
    'id_token' => 'a jwt token',
    'token_type' => 'Bearer',
    'refresh_token' => nil
  },
  'extra' => {
    'raw_info' => {
      'nickname' => info['nickname'],
      'name' => info['name'],
      'email' => info['email'],
      'email_verified' => true,
      'picture' => info['image'],
      'iss' => Faker::Internet.url,
      'sub' => 'github|1812732',
      'aud' => Faker::Internet.uuid,
      'iat' => 1.day.since.to_i,
      'exp' => 1.day.since.to_i,
      'nonce' => Faker::Internet.uuid
    }
  }
}
