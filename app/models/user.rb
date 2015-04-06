class User < ActiveRecord::Base
  has_many :authorizations
  has_many :sheets
  has_many :tokens

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

  def some_conversion_method(worksheet_hash)
    table = {}
    worksheet_hash["feed"]["entry"].each do |entry|
      title = entry["title"]
      content = entry["content"]
      col_row = title["$t"].match(/^([A-Z*])(\d*)$/)

      table[col_row[2]] ||= []
      table[col_row[2]].push(content["$t"])
    end

    headers = table.delete("1")
    rows = []
    table.values.each do |row|
      result = {}
      row.each_with_index do |item, index|
        # classify the item
        result[headers[index]] = item.strip
      end
      rows << result
    end

    return {
      headers: headers,
      rows: rows,
    }
  end



  # lines.each do |values|
  #   sheet.sheet_rows.create(Hash[keys.zip(values)])
  # end

  def google_sheets
    @gsheets ||= fetch_google_sheets
  end


end
