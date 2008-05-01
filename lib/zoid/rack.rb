require 'rack'

module Rack #:nodoc:

  class Request #:nodoc:
    POST_TUNNEL_METHODS_ALLOWED = %w(PUT DELETE OPTIONS HEAD)

    def request_method
      if post_tunnel_method?
        params['_method'].upcase
      else
        @env['REQUEST_METHOD']
      end
    end

    private

    def post_tunnel_method?
      @env['REQUEST_METHOD'] == 'POST' && POST_TUNNEL_METHODS_ALLOWED.include?(self.POST.fetch('_method', '').upcase)
    end
  end


  module Adapter
    class Zoid

      def initialize(app)
        @app = app
      end

      def call(env)
        [200,{"Content-Type" => "text/html"}, "Welcome to #{@app.name}!"]
      end

    end
  end  

end

module Zoid


  def self.run(handler,app)
    case handler.to_sym
    when :mongrel
      Rack::Handler::Mongrel.run(Rack::Adapter::Zoid.new(app), :Port => 7777) do |server|
        trap(:INT) do
          server.stop
        end
      end
    else
      raise ArgumentError, "Unknown Rack handler #{handler}"
    end
  end

end
