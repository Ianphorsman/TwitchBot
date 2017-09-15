class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def default_react_params
    @react_params = {
        :context => 'ready'
    }
    @react_params
  end
  helper_method :default_react_params



end
