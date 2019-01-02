class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

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

  
  def modal_edit_user
    begin
    @user = User.find(params[:user_id])
    type = params[:user_type]
    name = params[:user_name]

    if type == '2'
      admin = true
    else
      admin = false
    end

    @user.name = name
    @user.admin = admin
    @user.save

    respond_to do |format|
            format.json { render :json => {"status":"ok"}  }
         end

    rescue => error
      redirect_to users_path, alert: error.message
    end
  end

  def modal_create_user
    begin
      email = params[:user_email]
      type = params[:user_type]
      name = params[:user_name]
      password = params[:password]
      password_confirm = params[:password_confirm]

      if type == '2'
      admin = true
    else
      admin = false
    end

      if (password == password_confirm)
        u=User.new
        u.name = name
        u.email = email
        u.admin = admin
        u.password = password
        u.save

        respond_to do |format|
            format.json { render :json => {"status":"ok"}  }
         end

       else
        respond_to do |format|
            format.json { render :json => {"status":"Heslo sa nezhoduje"}  }
         end
       end



    rescue => error
      redirect_to users_path, alert: error.message
    end
  end

  def destroy
    begin
    super
  rescue=>error
    redirect_to users_path, alert: error.message
  end
  end

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
