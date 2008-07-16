class AddStatusInfoToSearch < ActiveRecord::Migration
  def self.up
    add_column :flickr_searches, :current_page, :integer, :default => 0
    add_column :flickr_searches, :current_photo, :integer, :default => 0
    add_column :flickr_searches, :photos_per_page, :integer
  end

  def self.down
    remove_column :flickr_searches, :photos_per_page
    remove_column :flickr_searches, :current_photo
    remove_column :flickr_searches, :current_page
  end
end
