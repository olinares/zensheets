Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
    {
      scope: [
        'https://www.googleapis.com/auth/plus.login',
        'https://spreadsheets.google.com/feeds',
        'https://www.googleapis.com/auth/drive',
        'https://docs.google.com/feeds',
        'http://docs.google.com/feeds',
        'https://www.googleapis.com/auth/userinfo.profile'],
      access_type: 'offline'
    }
end
