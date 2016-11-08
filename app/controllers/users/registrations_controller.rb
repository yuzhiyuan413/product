class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def bind
    
  end

  def create_bind
    @current_user = User.find_by_email(params[:user][:email])
    if @current_user.present?
      set_user_omniauth(@current_user)
      sign_in(:user, @current_user)
      redirect_to root_path
    else
      flash.alert = "用户不存在，请先去注册。"
      render action: 'bind'
    end
    
    
  end

  # POST /resource
  def create
    user = User.find_by(email: sign_up_params[:email])
    if user
      flash.alert = "用户已经存在!"
      render action: 'new' and return 
    else
      super do |resource|
        set_user_omniauth(resource)
      end
    end
     
  end

  def send_sms
    verify_number = ((rand * 9 + 1) * 1000).to_i
    mobile = params[:verify][:mobile]
    p "--------------------------手机号码：#{mobile}验证码：#{verify_number}-----------------------------"
    # if User.by_mobile(mobile).size > 0
    #   # flash.alert = "该用户已经存在!"
    #   respond_to do |format|
    #     format.json { render json: {SubmitResult: {code: '0', msg: '用户已经存在！'}} }
    #   end
    # else
      session[:verify] = {"mobile" => mobile, "verify_number" => verify_number}
      sms_params = {}.tap do |x|
        x["account"] = sms_conf['sms_account']['account']
        x["password"] = sms_conf['sms_account']['password']
        x["mobile"] = mobile
        # x["content"] = "您的验证码是：#{verify_number}。请不要把验证码泄露给其他人。"
        x["content"] = "您的校验码是：#{verify_number}。请不要把校验码泄露给其他人。"
      end
      uri = URI.parse("http://106.veesing.com/webservice/sms.php?method=Submit")
      res = Net::HTTP.post_form(uri, sms_params)
      result = Hash.from_xml(res.body)
      respond_to do |format|
        format.json { render json: result }
      end
    # end
  
  end

  def sms_verify
    mobile = params[:verify][:mobile]
    verify_num = params[:verify][:sms_verify_number]
    params_verify = {
      "mobile" => mobile,
      "verify_number" => verify_num.to_i
    }
    verify_temp = session[:verify]
    p "------------params_verify:#{params_verify}--------verify_temp:#{verify_temp.to_hash}"
    if verify_temp == params_verify
      #mobile  where
      user = User.by_mobile(mobile)
      if user.size == 0
        user = User.new do |u|
          u.email = "#{mobile}@126.com"
          u.current_name = mobile
          u.password = "123456"
          u.mobile = mobile
        end
        user.save
      end
      sign_in(:user, user)
      redirect_to root_path
    else
      redirect_to users_new_by_mobile_url, alert: '验证码输入错误!'
    end

  end

  private
    def sms_conf
      YAML.load_file(Rails.root.join("config", "sms_config.yml"))
    end

    def set_user_omniauth resource
      omniauth = session[:omniauth]
      if omniauth
        authentication = Authentication.where(user_id: resource.id, uid: omniauth["uid"]).first
        Authentication.create_from_hash(resource.id, omniauth) unless authentication
        resource.update(
          provider: omniauth["provider"],
          uid: omniauth["uid"],
          current_name: omniauth["current_name"],
          profile_image: omniauth["profile_image"]
        )
      end
    end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
