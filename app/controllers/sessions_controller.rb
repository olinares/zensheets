class SessionsController < ApplicationController

  def new
    # @auth = Auth.new
  end

  def create
    @user = Authorization.user_from_auth_hash(auth_hash)

    if @user
      login_user @user
      create_or_update_user_token(@user)
      redirect_to root_path
    else
      redirect_to root_path, notice:"There is an error"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'logged out'
  end


  def login_user(user)
    session[:user_id] = user.id
  end


  def create_or_update_user_token(user)
    credentials = auth_hash['credentials']
    user.tokens.create(
    access_token: credentials['token'],
    refresh_token: "no-refresh-token",
    expires_at: Time.at(credentials['expires_at']).to_datetime)
  end

  def auth_hash
    @auth ||= request.env['omniauth.auth'].to_hash
    unless @auth.has_key?('uid') && @auth.has_key?('provider')
      redirect_to root_path, notice: "Bad Auth, missing uid or provider"
      return
    end
    @auth
  end
end
