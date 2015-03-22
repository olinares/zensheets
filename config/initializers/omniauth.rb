Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
    {
      # :name => "google",
      # :scope => "email, profile, drive, https://www.googleapis.com/auth/drive",
      # :prompt => "select_account",
      # :image_aspect_ratio => "square",
      # :image_size => 50,
      # :access_type => "offline"

      scope: ['drive',
      'https://www.googleapis.com/auth/userinfo.profile'],
      access_type: 'offline'
    }
end
