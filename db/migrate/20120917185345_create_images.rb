class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :sizes

      t.timestamps
    end
  end
end
