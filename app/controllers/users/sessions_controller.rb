# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if !params[:user].nil?
      super
    else
      @user = User.new_guest
      @company = Company.new_guest
      token = helpers.generate_token_with_prefix("Guest#")

      @user.email = token.concat("@email.com")
      @company.name = token

      if @company.save 
        @user.company_id = Company.find_by(name:token).id
        @user.password = token
        @user.save
        session[:user_id] = @user.id
        sign_in(:user, @user)
        redirect_to "/quotes"

      else
        render "new", status: :unprocessable_entity
        flash[:alert] = "Something went wrong."
      end

    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
