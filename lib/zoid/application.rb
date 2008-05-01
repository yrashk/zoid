module Zoid
  nsurl "http://strokedb.com/zoid"
  Application = StrokeDB::Meta.new do
    validates_presence_of :name
    validates_presence_of :nsurl

    def route_for(method, path)
      case path
      when /^\/(\w+)[\/]?$/
        app_module.const_get($1.camelize)
      when /^\/(\w+)\/#{StrokeDB::UUID_RE}$/
        store.find($2)
      when /^\/(\w+)\/#{StrokeDB::UUID_RE}.#{StrokeDB::UUID_RE}$/
        store.find($2,$3)
      end
    end

    private

    def app_module
      @module ||= Module.find_by_nsurl(nsurl)
    end

  end
end