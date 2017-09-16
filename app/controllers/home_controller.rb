class HomeController < ApplicationController

  before_action :default_react_params

  def index
    start_twitch_client
    @twitch_client.get_video_frame_from_stream('disguisedtoasths')
  end

end
