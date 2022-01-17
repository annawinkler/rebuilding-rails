require 'rulers/array'
require 'rulers/controller'
require 'rulers/dependencies'
require 'rulers/file_model'
require 'rulers/routing'
require 'rulers/version'
require 'rulers/util'

module Rulers
  class Error < StandardError; end

  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        return [200,
                {'Content-Type' => 'text/html'},
                [File.read("public/index.html")]]
      end

      klass, action = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(action)
        [200, {'Content-Type' => 'text/html'},
         [text]]
      rescue StandardError => e
        [500, {'Content-Type' => 'text/html'},
         ["Sorry about the error!<br>#{e}"]]
      end
    end
  end
end
