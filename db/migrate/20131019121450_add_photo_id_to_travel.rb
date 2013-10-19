class AddPhotoIdToTravel < ActiveRecord::Migration
  def change
    add_column :travels, :photo_id, :integer
    add_index :travels, :photo_id
  end
end
