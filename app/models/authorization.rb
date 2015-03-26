class Authorization < ActiveRecord::Base

  belongs_to :user
  validates :uid, :provider, presence: true
  # validates :uid, :scope => :provider, presence: true

  # find or create user by auth[provider ]and auth[uid]
  def self.user_from_auth_hash(auth_hash)
    auth = where(auth.slice("uid", "provider")).first_or_create
    if auth.user
      user = auth.user
    else
      # create a user
      user = User.create({name: "Blair is awesome"})
      # put the user.id into the auth object.(create relationship between auth and user)
      auth.user_id = user.id
      auth.save
    end
    user
  end
  
end
