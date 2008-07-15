# Helper for blueprint css framework at http://code.google.com/p/blueprintcss
# Options
#   :plugins takes an array of plugins to load by name like :plugins => [:buttons, 'fancy-type']
#   :compressed => true or false (default: true) on whether or not to use compressed css files
#   :show_grid => true or false (default: false) on whether or not to draw grid on container background

module Blueprint
  class << self
    # shortcut for <tt>enable_actionpack</tt>
    def enable
      enable_actionpack
    end

    # mixes in Blueprint::ViewHelpers in ActionView::Base
    def enable_actionpack
      return if ActionView::Base.instance_methods.include? 'blueprint'
      require 'blueprint/view_helpers'
      ActionView::Base.class_eval { include ViewHelpers }
    end
	end
end

if defined?(Rails)
  Blueprint.enable
end
