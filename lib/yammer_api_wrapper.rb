module YammerAPIWrapper

  YAMMER_API_BASE_URL = "https://www.yammer.com/api/v1/"

  def self.get_networks(access_key)
    call :get, "networks/current.json", access_key
  end

  def self.get_groups(access_key)
    call :get, "groups.json", access_key
  end

  def self.get_oauth_keys(access_key)
    call :get, "oauth/tokens.json", access_key
  end

protected

  def self.parse_result(result)
    return false unless result && result.env[:status] == 200
    JSON.load(result.body) rescue false
  end

  def self.http
    @faraday ||= Faraday.new
  end

  def self.call(method, url, access_key, params={})
    result = nil
    case method.to_s.downcase
    when "get"
      result = http.get generate_url(url, access_key)
    when "post"
      result = http.post generate_url(url, access_key), params
    end
    parse_result(result)
  end

  def self.generate_url(url, access_key)
    "#{YAMMER_API_BASE_URL}#{url}?access_token=#{access_key}"
  end

end
