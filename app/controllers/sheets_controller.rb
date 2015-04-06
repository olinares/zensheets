class SheetsController < ApplicationController
  before_filter :require_login

  def index
    if current_user
      @sheets = current_user.sheets
      # current_user is instance of User
      @google = current_user.google_sheets
    else
      redirect_to new_session_path
    end
  end

  def sheet_key
    if params[:sheet_key].blank?
      redirect_to root_path and return
    end
    if current_user
      @sheet = current_user.fetch_google_sheet_by_key(params[:sheet_key])
    else
      redirect_to new_session_path
    end
  end

  def worksheet
    if current_user
      worksheet = current_user.fetch_google_worksheet(params[:sheet_key], params[:worksheet_id])
      @worksheet = current_user.some_conversion_method(worksheet)
      respond_to do |format|
        format.html
        format.json { render json: @worksheet }
      end
    else
      redirect_to new_session_path
    end
  end

  def show
    @sheet = current_user.fetch_google_sheet_by_id(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @sheet }
    end
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_path
    end
  end
end
