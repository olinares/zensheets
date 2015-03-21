Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
    scope: ['drive',
    'https://www.googleapis.com/auth/drive'],
    access_type: 'offline'}
  end
