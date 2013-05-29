Spree.user_class.class_eval do
  attr_accessible :provider, :uid
  devise :omniauthable, :omniauth_providers => [:vkontakte, :facebook]

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = self.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = self.create(provider:auth.provider,
                         uid:auth.uid,
                         login: auth.info.first_name,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

   def self.find_for_vkontakte_oauth(auth, signed_in_resource=nil)
    user = self.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = self.create(provider:auth.provider,
                         uid:auth.uid,
                         login: auth.info.first_name,
                         email: "#{auth.uid}@vk.com",
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

end
