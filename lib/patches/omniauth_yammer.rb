module OmniAuth
  module Strategies
    class Yammer
      def build_access_token
        access_token = super
        token = access_token.token['token']
        @access_token = ::OAuth2::AccessToken.new(client, token, access_token.params)
      end
    end
  end
end
