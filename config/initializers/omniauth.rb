Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github,
             'ec3e97f5ec1b11a3f089',
             '9bcb9d5e1e2079bd8fa8c17e0e45db59a39874a9'
  else
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
  end
end
