module Gitki

# render the site with strapdown.js to convenrt markdonw content into html on the cleint side
  class StrapdownJs

    attr_reader :template

    def render_content(file, opts = {})
      metadata = {
	:content => file
      }
      @template.render self, metadata
    end


    private

    def template
      unless @template
	template = File.join("lib", "templates", self.class.name.gsub('\s', '_'))
	@template = Tilt::ERBTemplate.new(template)
      end
      @template
    end

  end

end

