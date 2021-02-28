class ChangePasswordController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  
  def edit
  end

  def update
    if @user.authenticate(params[:user][:old_password])
      if @user.update(password_params)
        flash[:cuccess] = "Password updated"
        redirect_to @user
      else
        redirect_to @user
      end
    else
      render 'edit'
    end
  end
  
  private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def validate_password
      params.permit(:old_password)
    end
    
    def get_user
      @user = User.find_by(id: params[:id])
    end
end
