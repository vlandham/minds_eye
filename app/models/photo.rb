class Photo < ActiveRecord::Base
  # using the acts_as_taggable_on_steriods
  # Found here: http://github.com/mattetti/acts_as_taggable_on_steroids/
  # To install used the command:
  # ./script/plugin install git://github.com/mattetti/acts_as_taggable_on_steroids.git
  acts_as_taggable 
  acts_as_fleximage :image_directory => 'public/images/photos'
  belongs_to :flickr_search
  
  def self.search(search, page)
    if search
      tags = search.split.join(", ")
      self.find_tagged_with(*tags).paginate :page => page, :order => 'created_at DESC'
    else
      paginate  :page => page, :order => 'created_at ASC'
    end
  end
end
