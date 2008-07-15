module Blueprint
	module ViewHelpers
  	def blueprintcss(options = {})
  	  options[:compressed] = false unless options.has_key?(:compressed)

  	  screen_css = options[:compressed] ? 'screen' : 'screen'
  	  print_css = options[:compressed] ? 'print' : 'print'
  	  ie_css = 'lib/ie'
  	  if options[:compressed] && File.exist?(File.join(RAILS_ROOT, 'stylesheets', 'blueprint', 'ie.css'))
  	    ie_css = 'ie'
  	  end
  	  outp = blueprintcss_stylesheet(screen_css, :media => 'screen, projection') + "\n"
  	  outp << blueprintcss_stylesheet(print_css, :media => 'print') + "\n"
  	  outp << "<!--[if IE]>\n"
  	  outp << "  " + blueprintcss_stylesheet(ie_css, :media => 'screen, projection') + "\n"
  	  outp << "<![endif]-->\n"

  	  if options[:plugins]
  	    options[:plugins].to_a.each do |plugin|
  	      plugin_name = plugin
  	      if options[:compressed]
  	        if File.exist?(File.join(@staticmatic.site_dir, 'stylesheets', 'blueprint', 'plugins', plugin.to_s, "#{plugin}-compressed.css"))
  	          plugin_name = "#{plugin}-compressed"
  	        end
  	      end
  	      outp << blueprintcss_stylesheet("plugins/#{plugin}/screen", :media => 'screen, projection') + "\n"
  	    end
  	  end

  	  if options[:show_grid]
  	    outp << content_tag(:style, :type => 'text/css') do 
  	      show_output = "\n/*<![CDATA[*/\n"
  	      show_output << "  .container { background: url('/stylesheets/blueprint/src/grid.png'); }\n"
  	      show_output << "/*]]>*/\n"
  	      show_output
  	    end
  	  end

  	  outp
  	end

  	def blueprintcss_stylesheet(name, options = {})
  	  href = "/stylesheets/blueprint/#{name}.css"
  	  tag(:link, {:href => href, :rel => 'stylesheet', :type => 'text/css'}.merge(options)) 
  	end
	end
end
