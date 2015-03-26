require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      raise if already_built_response?

      folder_name = self.class.to_s.underscore
      template = ERB.new(
        File.read(
          "views/#{folder_name}/#{template_name}.html.erb")
      )
      render_content(template.result(binding),"text/html")
    end
  end
end
