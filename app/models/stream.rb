class Stream < ActiveRecord::Base

  belongs_to :user

  scope :waiting, where("state = 'waiting'")
  scope :active, where("state = 'active'")
  scope :finished, where("state = 'finished'")

  def url_slug
    name.gsub(/[^0-9a-z]/i, '').downcase
  end

  def post_yammer_update(user)
    YammerAPIWrapper.post_message(user.get_auth_for_group(group_id), group_id, yammer_message)
  end

  def yammer_message
    "I just started broadcasting on YamLive. Check it out: http://yamlive.mchristopher.com/streams/#{id}?_a=#{auth_string}"
  end

  def auth_string
    b64encode("#{OpenSSL::HMAC.digest('sha1', Dreamlive::Application.config.secret_token, "yamlive_stream_#{id}")}")
  end

  def b64encode(str)
    Base64.encode64(str).gsub(/[\s=]+/, "").gsub("+", "-").gsub("/", "_")
  end

  def b64decode(str)
    Base64.decode64(str.gsub("-", "+").gsub("_", "/"))
  end

end
