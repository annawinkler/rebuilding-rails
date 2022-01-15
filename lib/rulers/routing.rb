module Rulers
  class Application
    def get_controller_and_action(env)
      _, controller, action, after =
        env['PATH_INFO'].split('/', 4) # split no more than 4 times
      controller = controller.capitalize # 'People'
      controller += 'Controller' # 'PeopleController'

      [Object.const_get(controller), action]
    end
  end
end