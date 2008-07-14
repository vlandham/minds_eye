class CreateFlickrSearches < ActiveRecord::Migration
  def self.up
    create_table :flickr_searches do |t|
      t.string :search_parameter
      t.string :search_type
      t.integer :start_page
      t.integer :end_page

      t.timestamps
    end
  end

  def self.down
    drop_table :flickr_searches
  end
end
