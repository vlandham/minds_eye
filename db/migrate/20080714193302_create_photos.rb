class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :flickr_id
      t.datetime :taken_at
      t.datetime :uploaded_at
      t.text :description
      t.string :title
      t.integer :license
      t.string :flickr_url
      t.integer :flickr_search_id
      t.string :image_filename
      t.integer :image_width
      t.integer :image_height

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
