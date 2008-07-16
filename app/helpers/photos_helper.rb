module PhotosHelper
  def icon_of(name, extension="png")
    "images/icons/#{name}.#{extension}"
  end
end
