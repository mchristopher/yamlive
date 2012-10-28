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
    "I just started broadcasting on YamLive. Check it out: http://yamlive.mchristopher.com/streams/#{id}"
  end

end
