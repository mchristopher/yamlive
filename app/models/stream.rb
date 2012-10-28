class Stream < ActiveRecord::Base

  belongs_to :user

  scope :waiting, where("state = 'waiting'")
  scope :active, where("state = 'active'")
  scope :finished, where("state = 'finished'")

  def url_slug
    name.gsub(/[^0-9a-z]/i, '').downcase
  end

end
