module PhotosHelper
  def icon_of(name, extension="png")
    "icons/#{name}.#{extension}"
  end
end
