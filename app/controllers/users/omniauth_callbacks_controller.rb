class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def weibo
    omniauth_process
  end
  
  protected
  def omniauth_process
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.where(provider: omniauth.provider, uid: omniauth.uid.to_s).first
    if authentication
      set_flash_message(:notice, :signed_in)
      sign_in(:user, authentication.user)
      redirect_to root_path
    elsif current_user
      authentication = Authentication.create_from_hash(current_user.id, omniauth)
      current_user.update_authentication(omniauth)
      #set_flash_message(:notice, :add_provider_success)
      # redirect_to authentications_path
      redirect_to root_path
    else
      omniauth_temp = {}.tap do |x|
        w_name = omniauth.except("extra")["info"]["name"]
        w_profile_image = omniauth.except("extra")["info"]["image"]
        x[:provider] = omniauth.provider
        x[:uid] = omniauth.uid
        x[:current_name] = w_name
        x[:profile_image] = w_profile_image
      end
      session[:omniauth] = omniauth_temp
      set_flash_message(:notice, :fill_your_email)
      redirect_to new_user_registration_url
    end
  end

  def after_omniauth_failure_path_for(scope)
    # new_user_registration_path
  end



   # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

end
