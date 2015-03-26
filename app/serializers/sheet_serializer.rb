class SheetSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :url, :name
end
