class Sheet < ActiveRecord::Base
  belongs_to :user
  serialize :headers
  serialize :rows
end
