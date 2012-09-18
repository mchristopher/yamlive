class Stream < ActiveRecord::Base

  belongs_to :user

  scope :waiting, where("state = 'waiting'")
  scope :active, where("state = 'active'")
  scope :finished, where("state = 'finished'")

end
