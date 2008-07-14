class AddOtherFlickrUrlsToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :flickr_url_large, :string
    add_column :photos, :flickr_url_medium, :string
    add_column :photos, :flickr_views, :integer
  end

  def self.down
    remove_column :photos, :flickr_views
    remove_column :photos, :flickr_url_medium
    remove_column :photos, :flickr_url_large
  end
end
