module Zoid
  nsurl "http://strokedb.com/zoid"
  Application = StrokeDB::Meta.new do
    validates_presence_of :name
    validates_presence_of :nsurl

    def route_for(method, path)
      case path
      when /^\/(\w+)(\/)?$/
        app_module.const_get($1.camelize)
      end
    end

    private

    def app_module
      @module ||= Module.find_by_nsurl(nsurl)
    end

  end
end