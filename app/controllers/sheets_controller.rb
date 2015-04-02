class SheetsController < ApplicationController
  def index

    if current_user
      @sheets = current_user.sheets
      # current_user is instance of User
      @google = current_user.google_sheets
    else
      redirect_to new_session_path
    end
  end

  def show
    @sheets = Sheet.all
    render json: @sheets
  end
end
