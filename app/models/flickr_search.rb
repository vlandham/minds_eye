class FlickrSearch < ActiveRecord::Base
  has_many :photos
  FLICKR_CONFIG_FILE = "#{RAILS_ROOT}/config/flickr.yml"
  def execute
    flickr = Flickr.new(FLICKR_CONFIG_FILE)
    
    (self.start_page..self.end_page).each do |current_page|
        # Get the current page of photos
        photos = flickr.photos.search(self.search_type.to_sym => self.search_parameter, :page => current_page)
        # If empty, no more photos, so break
        break if photos.empty?
        photos.each do |raw_photo|
          save_photo(raw_photo)
        end
    end
  end
  
  def save_photo(raw_photo)
    # don't add duplicate photos (based on flickr id)
    return unless Photo.find_by_flickr_id(raw_photo.id).nil?
    # TODO: better way to specify all these parameters? 
    photo = Photo.new(
      :flickr_id => raw_photo.id.to_i,
      :taken_at => raw_photo.taken_at,
      :uploaded_at => raw_photo.uploaded_at,
      :description => raw_photo.description,
      :title => raw_photo.title,
      :license => raw_photo.license,
      :flickr_url => raw_photo.url(:original),
      :flickr_search_id => self.id,
      :image_file_url => raw_photo.url(:original)
    )
    if photo.save
      photo.tag_list.add(*raw_photo.tags.split)
    end
  end
  
end
