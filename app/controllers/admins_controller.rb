class AdminsController < ApplicationController
  
  include AdminAuthentication
  
  before_filter :check_new_admin_can_be_created, only: [:new,:create]
  
  def new
  end
  
  def create
    return redirect_to new_admin_path if invalid_first_admin(admin_params)
    
    admin = Admin.new(email: admin_params[:email])
    if admin.validate_then_save(admin_params)
      flash[:notices] = ["#{admin.email} admin account created"]
      sign_in(admin)
    else
      flash[:errors] = admin.custom_errors
      redirect_to new_admin_path
    end
  end
  
  private
  
  def admin_params
    params.require(:admin).permit(:email,:password,:password_confirmation)
  end
  
end