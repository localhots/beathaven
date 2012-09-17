class CreateArtistInfos < ActiveRecord::Migration
  def change
    create_table :artist_infos do |t|
      t.integer :artist_id
      t.string :lang
      t.text :bio

      t.timestamps
    end
  end
end
