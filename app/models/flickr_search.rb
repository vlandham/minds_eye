class FlickrSearch < ActiveRecord::Base
  has_many :photos, :dependent => :destroy
  validates_presence_of :search_parameter, :search_type, :start_page, :end_page
  validates_numericality_of :start_page, :end_page  
  FLICKR_CONFIG_FILE = "#{RAILS_ROOT}/config/flickr.yml"
  
  
  def relative_current_page
    (self.current_page-self.start_page)+1
  end
  
  def total_pages
    (self.end_page - self.start_page)+1
  end
  
  def execute
    flickr = Flickr.new(FLICKR_CONFIG_FILE)
    
    (self.start_page..self.end_page).each do |current_page|
        # Get the current page of photos
        photos = flickr.photos.search(self.search_type.to_sym => self.search_parameter, :page => current_page)
        # If empty, no more photos, so break
        break if photos.empty?
        
        self.current_page = current_page
        self.photos_per_page = photos.size
        self.save!
        photos.each_with_index do |raw_photo, index|
          self.update_attribute(:current_photo, index+1)
          begin
            save_photo(raw_photo)
          rescue RuntimeError
            RAILS_DEFAULT_LOGGER.error("\n Error: could not save photo #{raw_photo.flickr_id} \n")
          rescue Exception => msg
            RAILS_DEFAULT_LOGGER.error("\n Error in execute: #{msg}\n") #just to be on the safe side
          rescue => msg
            RAILS_DEFAULT_LOGGER.error("\n Error in execute: #{msg}\n")
          end
        end
    end #each page
    self.update_attribute(:completed, true)
  end
  
  def save_photo(raw_photo)
    # don't add duplicate photos (based on flickr id)
    return unless Photo.find_by_flickr_id(raw_photo.id).nil?
    # TODO: better way to specify all these parameters? 
    photo_url = raw_photo.url(:original) || raw_photo.url(:large) || raw_photo.url(:medium) || raw_photo.url(:small) || "error"
    photo = Photo.new(
      :flickr_id => raw_photo.id.to_i,
      :taken_at => raw_photo.taken_at,
      :uploaded_at => raw_photo.uploaded_at,
      :description => raw_photo.description,
      :title => raw_photo.title,
      :license => raw_photo.license,
      :flickr_url => photo_url,
      :flickr_url_large => raw_photo.url(:large),
      :flickr_url_medium => raw_photo.url(:medium),
      :flickr_views => raw_photo.views.to_i,
      :flickr_search_id => self.id,
      :image_file_url => photo_url
    )
    if photo.save
      photo.tag_list.add(*raw_photo.tags.split)
      photo.save
    end
  end
  
end
