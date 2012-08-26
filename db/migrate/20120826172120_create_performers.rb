class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.integer :track_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
