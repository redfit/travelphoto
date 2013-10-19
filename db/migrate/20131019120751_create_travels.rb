class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.text :title
      t.date :startdate
      t.date :enddate
      t.references :user, index: true

      t.timestamps
    end
  end
end
