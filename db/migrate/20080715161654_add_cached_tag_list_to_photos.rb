class AddCachedTagListToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :cached_tag_list, :string
  end

  def self.down
    remove_column :photos, :cached_tag_list
  end
end
