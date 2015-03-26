class SheetsController < ApplicationController
  def index

    if current_user
      @sheets = current_user.sheets
      # current_user is instance of User
      @sheets_on_google = current_user.fetch_google_sheets
    else
      redirect_to login_path
    end
  end
end
