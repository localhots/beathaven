class AddIsHiddenFieldToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :is_hidden, :boolean, default: false
  end
end
