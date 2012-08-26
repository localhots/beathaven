class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :rovi_id
      t.string :name
      t.boolean :is_group
      t.text :bio
      t.string :pic

      t.timestamps
    end
  end
end
