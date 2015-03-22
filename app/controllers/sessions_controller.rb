class SessionsController < ApplicationController
  layout false

  def new
    # @auth = Auth.new
  end

  def create
    # Storing token ID in session
    @auth = request.env['omniauth.auth'].to_hash

    # find or create user by auth[provider ]and auth[uid]
    # update user details
    # on the user, create a token like you're doing below
    byebug
    token = Tokens.create(
    user_id: user.id,
    access_token: @auth['token'],
    refresh_token: @auth['refresh_token'],
    expires_at: Time.at(@auth['expires_at']).to_datetime)
    session[:user_id] = user.id
    redirect_to root_path
  end
end
