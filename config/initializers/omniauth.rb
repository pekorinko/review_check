Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github,
             Rails.application.credentials.github[:client_id_dev],
             Rails.application.credentials.github[:client_secret_dev]
  else
    provider :github,
             Rails.application.credentials.github[:client_id],
             Rails.application.credentials.github[:client_secret]
  end
end
