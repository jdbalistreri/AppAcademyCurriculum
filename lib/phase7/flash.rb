
require_relative '../phase6/router'
require_relative '../phase6/controller_base'

module Phase7

  class ControllerBase < Phase6::ControllerBase
    def redirect_to(url)
      super
      self.flash.store_flash(res)
    end

    def render_content(content, content_type)
      p "called render content 7!"
      super
      self.flash.store_flash(res)
    end

    # method exposing a `Session` object
    def flash
      @flash ||= Flash.new(req)
    end

  end


  class Flash
    def initialize(req)
      unparsed_flash = req.cookies.find { |cookie| cookie.name == "_rails_lite_flash" }
      p "unparsed flash #{unparsed_flash}"
      @flash = JSON.parse(unparsed_flash.value) if unparsed_flash
      p "received #{@flash}"
      @flash ||= {}
      @to_delete = @flash["to_delete"] || []
      @flash.delete("to_delete")
    end

    def [](key)
      @flash[key.to_s]
    end

    def []=(key, value)
      fail if key.to_sym == :to_delete

      @flash[key.to_s] = value

      @to_delete << key if @now
      @now = false
    end

    def now
      @now = true
      self
    end

    def store_flash(res)
      @flash = @flash.delete_if { |key, value| @to_delete.include?(key) }
      @to_delete = @flash.keys
      @flash["to_delete"] = @to_delete
      p "sent down #{@flash}"
      res.cookies << WEBrick::Cookie.new("_rails_lite_flash", @flash.to_json )
    end

  end

end
