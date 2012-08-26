class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.string :rovi_id
      t.string :title
      t.integer :year
      t.string :pic

      t.timestamps
    end
  end
end
