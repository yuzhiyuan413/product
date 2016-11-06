class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # super
    p '*' * 100
    p sign_up_params
    user = User.find_by(email: sign_up_params[:email])
    if user
      flash.alert = "用户已经存在!"
      render action: 'new' and return 
    else
      User.create(sign_up_params)
      
    end
    redirect_to root_path
  end

  def send_sms
    verify_number = ((rand * 9 + 1) * 1000).to_i
    mobile = params[:verify][:mobile]
    p "--------------------------手机号码：#{mobile}验证码：#{verify_number}-----------------------------"
      
    if User.by_mobile(mobile).size > 0
      # flash.alert = "该用户已经存在!"
      respond_to do |format|
        format.json { render json: {SubmitResult: {code: '0', msg: '用户已经存在！'}} }
      end
    else
      session[:verify] = {mobile: mobile, verify_number: verify_number}
      sms_params = {}.tap do |x|
        x["account"] = sms_conf['sms_account']['account']
        x["password"] = sms_conf['sms_account']['password']
        x["mobile"] = mobile
        x["content"] = "您的验证码是：#{verify_number}。请不要把验证码泄露给其他人。"
      end
      uri = URI.parse("http://106.veesing.com/webservice/sms.php?method=Submit")
      res = Net::HTTP.post_form(uri, sms_params)
      result = Hash.from_xml(res.body)
      respond_to do |format|
        format.json { render json: result }
      end
    end
  
  end

  def sms_verify
    params_verify = {
      mobile: params[:verify][:mobile],
      verify_number: params[:verify][:sms_verify_number]
    }
    p params_verify
    verify_temp = session[:verify]
    p verify_temp == params_verify
    if verify_temp == params_verify

    end

  end

  private
    def sms_conf
      YAML.load_file(Rails.root.join("config", "sms_config.yml"))
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
