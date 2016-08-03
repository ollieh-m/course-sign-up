class AdminsController < ApplicationController
  
  include AdminAuthentication
  
  def new
  end
  
  def create
    admin = Admin.new(email: admin_params[:email])
    if admin.save_if_valid(admin_params)
      sign_in(admin)
      redirect_to admin_home_path
    else
      flash[:errors] = admin.errors
      redirect_to new_admin_path
    end
  end
  
  private
  
  def admin_params
    params.require(:admin).permit(:email,:password,:password_confirmation)
  end
  
end