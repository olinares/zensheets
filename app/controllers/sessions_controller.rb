class SessionsController < ApplicationController

  def new
    # @auth = Auth.new
  end

  def create
    @user = Authorization.user_from_auth_hash(auth_hash)

    if @user
      login_user @user
      # create_or_update_user_token(auth_hash)
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


  def create_or_update_user_token(auth)
    # token = Tokens.create(
    # user_id: user.id,
    # access_token: @auth['token'],
    # refresh_token: @auth['refresh_token'],
    # expires_at: Time.at(@auth['expires_at']).to_datetime)
  end

  def auth_hash
    @auth ||= request.env['omniauth.auth'].to_hash
    unless @auth.has_key?('uid') && @auth.has_key?('provider')
      redirect_to root_path, notice: "Bad Auth, missing uid or provider"
      return
    end
  end
end
