class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable


  devise :database_authenticatable, :registerable,
         :recoverable,:rememberable,:validatable,
         :omniauthable, :omniauth_providers => [:weibo]
  has_many :orders       
  scope :by_mobile, -> mobile_num { where(mobile: mobile_num) }

  def update_authentication omniauth
    provider = omniauth.provider
    uid = omniauth.uid
    w_name = omniauth.except("extra")["info"]["name"]
    w_profile_image = omniauth.except("extra")["info"]["image"]
    self.update(
      provider: omniauth.provider, 
      uid: omniauth.uid,
      current_name: w_name,
      profile_image: w_profile_image
    )
  end

  def show_name
      self.current_name.blank? ? self.email : self.current_name
  end


end
