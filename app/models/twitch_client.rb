class TwitchClient #< ApplicationRecord

  attr_accessor :twitch, :client_id, :secret_key, :redirect_uri, :scope, :data, :myself, :access_token

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
    @client_id = self.client_id
    @secret_key = self.secret_key
    @scope = self.scope
    @redirect_uri = self.redirect_uri
    @base_url = self.twitch.base_url
    @url = @base_url + '/oauth2/token'

    self.data = self.twitch.adapter.post(@url, :body =>{
        :client_id => @client_id,
        :client_secret => @secret_key,
        :grant_type => 'client_credentials',
        :scope => @scope.join(' ')
    })
    self.access_token = self.data[:body]["access_token"]
    p self.access_token

  end

  def say
  end


end
