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
    user = self
    token = user.current_token
    bearer = token.access_token
    key = "AIzaSyA9ihJ-_XoLFRX3jYIO4tRHxuz291rr0Jk"
    response = Faraday.get("https://www.googleapis.com/drive/v2/files?key=#{key}") do |req|
      req.headers['authorization'] = "Bearer #{bearer}"
    end

    JSON.parse(response.body)["items"]
  end

  def google_sheets
    @gsheets ||= fetch_google_sheets
  end

end
