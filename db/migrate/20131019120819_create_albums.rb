class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.text :title
      t.references :travel, index: true

      t.timestamps
    end
  end
end
