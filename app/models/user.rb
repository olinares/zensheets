class User < ActiveRecord::Base
  has_many :authorizations
  has_many :sheets

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end

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

  def fetch_google_sheets
    user = self
    token = user.token
    key = token.auth_key
    Faraday.get("https://www.googleapis.com/drive/v2/files?key=#{}")
  end

  #
end
