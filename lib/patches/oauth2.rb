module OAuth2
  class AccessToken
    def initialize(client, token, opts={})
      @client = client
      @token = token
      [:refresh_token, :expires_in, :expires_at].each do |arg|
        instance_variable_set("@#{arg}", opts.delete(arg) || opts.delete(arg.to_s))
      end
      @expires_in ||= opts.delete('expires')
      @expires_in &&= @expires_in.to_i
      @expires_at ||= Time.now.to_i + @expires_in if @expires_in
      @options = {:mode          => opts.delete(:mode) || :header,
                  :header_format => opts.delete(:header_format) || 'Bearer %s',
                  :param_name    => opts.delete(:param_name) || 'bearer_token'}
      @params = opts
    end
  end
end
