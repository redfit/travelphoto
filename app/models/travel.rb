class Travel < ActiveRecord::Base
  belongs_to :user
  belongs_to :cover_photo, class_name: "Photo", foreign_key: "photo_id"

  has_many :albums
end
