class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id
      t.string :rovi_id
      t.integer :disc_id
      t.integer :position
      t.string :title
      t.integer :duration

      t.timestamps
    end
  end
end
