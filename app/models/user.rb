class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable,
         :recoverable,:rememberable,:validatable,
         :omniauthable, :omniauth_providers => [:weibo]

  has_many :orders       
  #scope :by_status, -> status { where(status: status) }
  #User.by_status '1'
end
