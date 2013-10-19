class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album

  has_one :travel

  has_attached_file :image, styles: { thumb: ["64x64#", :png] }
end
