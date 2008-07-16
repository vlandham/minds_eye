class AddCompletedBoolToSearch < ActiveRecord::Migration
  def self.up
    add_column :flickr_searches, :completed, :boolean, :default => false
  end

  def self.down
    remove_column :flickr_searches, :completed
  end
end
