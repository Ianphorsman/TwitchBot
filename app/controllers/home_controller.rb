class HomeController < ApplicationController

  before_action :default_react_params

  def index
    start_twitch_client
  end

end
