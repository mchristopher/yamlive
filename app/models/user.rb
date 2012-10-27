class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :login, :password, :password_confirmation, :remember_me, :provider, :uid

  # Virtual attribute login to support authentication via username or email
  attr_accessor :login

  has_many :streams

  # Override to support authenticating via username or email
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value",
                                { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_provider_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(:name => auth.extra.raw_info.name,
                           :provider => auth.provider,
                           :uid => auth.uid,
                           :email => auth.info.email,
                           :username => auth.info.email,
                           :password => Devise.friendly_token[0,20]
                        )
    end
    user
  end

end
