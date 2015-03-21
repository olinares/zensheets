class SessionsController < ApplicationController
  layout false

  def new
  end

  def create
    # Storing token ID in session
    token = Token.create(
    access_token: @auth['token'],
    refresh_token: @auth['refresh_token'],
    expires_at: Time.at(@auth['expires_at']).to_datetime)
    session[:token_id] = token.id
    redirect_to root_path
  end
end
