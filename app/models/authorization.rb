class Authorization < ActiveRecord::Base

  belongs_to :user
  validates :uid, :provider, presence: true
  # validates :uid, :scope => :provider, presence: true

  # find or create user by auth[provider ]and auth[uid]
  def self.user_from_auth_hash(auth_hash)
    auth = where(:uid => auth_hash['uid'], :provider => auth_hash['provider']).first_or_create
    if auth.user
      user = auth.user
    else
      # create a user
      user = User.create({name: "Blair is awesome"})
      # put the user.id into the auth object.(create relationship between auth and user)
      auth.user_id = user.id
      auth.save
      # return user

    end
    user
  end

  def find_from_hash(hash)
    puts 'instance'
    # find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
  end
end
