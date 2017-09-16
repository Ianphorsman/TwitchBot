class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def default_react_params
    @react_params = {
        :context => 'ready'
    }
    @react_params
  end
  helper_method :default_react_params

  def start_twitch_client
    @twitch_client = TwitchClient.new({
        client_id: ENV['TWITCH_CLIENT_ID'],
        secret_key: ENV['TWITCH_SECRET_KEY'],
        redirect_uri: 'http://localhost:3000',
        scope: [
            'openid',
            'chat_login',
            'channel_feed_read'
        ]
                                      })
    @twitch_client.authorize
  end
  helper_method :start_twitch_client



end
