# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def icon_of(name, extension="png")
    "icons/#{name}.#{extension}"
  end
end
