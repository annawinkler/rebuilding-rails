require 'erubis'

module Rulers
  # A simple controller implementation
  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
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
