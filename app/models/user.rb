class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :login, :password, :password_confirmation, :remember_me, :provider, :uid

  # Virtual attribute login to support authentication via username or email
  attr_accessor :login

  serialize :networks
  serialize :groups

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

  def self.find_for_yammer_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider.to_s, :uid => auth.uid.to_s).first
    unless user
      user = User.create(:name => auth.extra.raw_info.name,
                           :provider => auth.provider,
                           :uid => auth.uid,
                           :email => auth.info.email,
                           :username => auth.info.email,
                           :password => Devise.friendly_token[0,20]
                        )
    end
    user.auth_key = auth.credentials.token
    user.update_networks unless (user.info_last_updated_at && user.info_last_updated_at > 30.minutes.ago)
    user
  end

  def generate_group_list
    generated_list = []
    self.networks.each do |network|
      network[:groups].each do |group|
        generated_list << ["#{network[:name]} - #{group[:name]}", group[:id]]
      end
    end
    generated_list
  end

  def update_networks
    network_list = []
    group_list = []
    oauth_keys = YammerAPIWrapper.get_oauth_keys(auth_key)
    return unless oauth_keys
    oauth_keys.each do |key|
      groups = []
      network_groups = YammerAPIWrapper.get_groups(key["token"])
      if network_groups && network_groups.count > 0
        network_groups.each do |group|
          groups << {:id => group["id"].to_s, :name => group["full_name"] || group["name"], :token => key["token"]}
          group_list << group["id"].to_s
        end
      end
      network_list << {:id => key["network_id"], :name => key["network_name"] || key["name"], :groups => groups, :permalink => key["network_permalink"]}
    end
    network_list
    self.networks = network_list
    self.groups = group_list.uniq
    self.info_last_updated_at = Time.now
    self.save!
  end

  def get_auth_for_group(group_id)
    networks.each do |network|
      network[:groups].each do |group|
        return group[:token] if group[:id] == group_id
      end
    end
    auth_key
  end

  def stream_authorized(stream)
    groups.any? {|g| stream.group_id.to_s == g.to_s}
  end

  def get_network_permaname_for_group(group_id)
    networks.each do |network|
      network[:groups].each do |group|
        return network[:permalink] if group[:id] == group_id.to_s
      end
    end
    nil
  end


protected

  def yammer
    @yammer ||= Yammer.new(
      :consumer_key => "OuNI4TJV66HFX2QTbeOhA",
      :consumer_secret => "F0Tpp1LMQmhywHHyLPuKZsz5yXUVPOta0a7Zt8Sg5I",
      :oauth_token => auth_key
    )
  end

end
