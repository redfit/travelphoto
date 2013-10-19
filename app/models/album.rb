class Album < ActiveRecord::Base
  belongs_to :travel
  has_many :photos
end
