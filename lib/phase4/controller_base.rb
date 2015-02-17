require_relative '../phase3/controller_base'
require_relative './session'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      fail if already_built_response?
      
      res.header["location"] = url
      res.status = 302

      @session.store_session(res)

      @already_built_response = true
    end

    def render_content(content, content_type)
      fail if already_built_response?

      res.content_type = content_type
      res.body = content

      @session.store_session(res)

      @already_built_response = true
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(req)
    end
  end
end
