class RemoveArtistBioAndImageFields < ActiveRecord::Migration
  def up
    remove_column :artists, :bio
    remove_column :artists, :pic
    remove_column :albums, :pic

    add_column :artists, :image_id, :integer, default: nil
    add_column :albums, :image_id, :integer, default: nil
  end

  def down
    add_column :artists, :bio, :text, default: nil
    add_column :artists, :pic, :string, default: nil
    add_column :albums, :pic, :string, default: nil

    remove_column :artists, :image_id
    remove_column :albums, :image_id
  end
end
