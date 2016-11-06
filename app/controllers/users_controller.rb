class UsersController < ApplicationController
	def bind
    @user = User.new
  end

  def create_bind
    @user = User.new
    omniauth = session[:omniauth]
    p params
    p '*' * 100
    @current_user = User.find_by_email(params[:user][:email])
    if @current_user.present?
      if omniauth
        authentication = Authentication.where(user_id: @current_user.id, uid: omniauth["uid"]).first
        Authentication.create_from_hash(@current_user.id, omniauth) unless authentication
        @current_user.update(
          provider: omniauth["provider"], 
          uid: omniauth["uid"],
          current_name: omniauth["current_name"],
          profile_image: omniauth["profile_image"]
        ) 
        redirect_to root_path
      end
    else
      flash.alert = "用户不存在，请先去注册。"
      render action: 'bind'
    end
    
    
  end
end