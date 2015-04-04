class User < ActiveRecord::Base
  has_many :authorizations
  has_many :sheets
  has_many :tokens

  # fetch_google_sheets

  # To call a method on an instance... you must define the instance method
  # To call a method on a CLASS... you must define a CLASS method....

  # def self.method_name
  #   # class
  # end
  #
  # def method_name
  #   # instance
  # end

  def current_token
    tokens.last
  end

  def fetch_google_sheets
    # response = Faraday.get("https://www.googleapis.com/drive/v2/files?key=#{key}") do |req|
    url = "https://spreadsheets.google.com/feeds/spreadsheets/private/full?alt=json"
    response = fetch(url)
    response["feed"]["entry"]
  end

  def fetch(url)
    user = self
    token = user.current_token
    bearer = token.access_token
    response = Faraday.get(url) do |req|
      req.headers['authorization'] = "Bearer #{bearer}"
    end
    JSON.parse(response.body)
  end

  def fetch_google_sheet_by_key(sheet_key = "1hH3vJSF5j0m-BVA6S6ZIEuP1VOkPRnUZD6KBrwoMbSM")
    url = "https://spreadsheets.google.com/feeds/worksheets/#{sheet_key}/private/basic?alt=json"
    response = fetch(url)
  end

  def fetch_google_worksheet(sheet_key, worksheet_id)
    url = "https://spreadsheets.google.com/feeds/cells/#{sheet_key}/#{worksheet_id}/private/basic?alt=json"
    response = fetch(url)
  end



  # lines.each do |values|
  #   sheet.sheet_rows.create(Hash[keys.zip(values)])
  # end

  def google_sheets
    @gsheets ||= fetch_google_sheets
  end


end
