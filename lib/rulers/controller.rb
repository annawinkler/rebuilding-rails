require 'erubis'
require 'rulers/file_model'

module Rulers
  # A simple controller implementation
  class Controller
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def get_response
      @response
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def response(text, status=200, headers={})
      raise 'Already responded!' if @response

      answer = [text].flatten
      @responses = Rack::Response.new(answer, status, headers)
    end

    def params
      request.params
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end

    def render(view_name, locals={})
      filename = File.join('app',
                           'views',
                           controller_name,
                           "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end
  end
end
