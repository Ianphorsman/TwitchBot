class TwitchClient #< ApplicationRecord

  attr_accessor :twitch, :client_id, :secret_key, :redirect_uri, :scope, :data, :myself, :access_token,
                :chat_queue, :video_frame_queue

  def initialize kwargs={}
    kwargs.each do |key, val|
      self.send("#{key}=", val)
    end
  end

  def authorize
    self.twitch = Twitch.new({
        client_id: self.client_id,
        secret_key: self.secret_key,
        redirect_uri: self.redirect_uri,
        scope: self.scope
                             })

    url = self.twitch.base_url + '/oauth2/token'
    self.data = self.twitch.adapter.post(url, :body =>{
        :client_id => self.client_id,
        :client_secret => self.secret_key,
        :grant_type => 'client_credentials',
        :scope => self.scope.join(' ')
    })
    self.access_token = self.data[:body]["access_token"]
    p self.access_token
  end

  def stream_from stream_name
    while true do
      # set interval for now
      # use ActionCable to get stream data
      # oh nevermind, that'll never happen
      self.get_video_frame_from_stream(stream_name)
    end
  end

  # look at twitch embedding video in iframe

  def get_video_frame_from_stream stream
    url = self.twitch.base_url + "/streams/#{stream}"
    response = self.twitch.adapter.request('get', url, :headers => {
      'Client-ID' => self.client_id
    })
    p response
  end

  def say
  end


  private

  def add_frame_to_queue response
    self.video_frame_queue << response
  end


end
