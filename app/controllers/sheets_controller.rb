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
      # @worksheet = json_parse_conversion(current_user.fetch_google_worksheet)
      worksheet = current_user.fetch_google_worksheet(params[:sheet_key], params[:worksheet_id])
      @worksheet = current_user.some_conversion_method(worksheet)
      respond_to do |format|
        format.html
        format.json { render json: @worksheet }
      end
      # render json: @worksheet
    else
      redirect_to new_session_path
    end
  end

  # def json_parse_conversion(worksheet)
  #   @worksheet.each do |key, value|
  #
  # end

  def show
    @sheet = current_user.fetch_google_sheet_by_id(params[:id])
    # we are here.

    respond_to do |format|
      format.html
      format.json { render json: @sheet }
    end
    # @sheets = Sheet.all
    # render json: @sheets
  end

end
