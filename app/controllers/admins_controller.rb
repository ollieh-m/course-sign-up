class AdminsController < ApplicationController
  
  include AdminAuthentication
  
  def new
  end
  
  def create
    admin = Admin.new(email: admin_params[:email])
    admin.save_if_valid(admin_params)
    # if admin.save_if_valid(admin_params)
    #   #create session for the admin
    #   #redirect to the admin home page
    # else
    #   #display flash using errors
    # end
  end
  
  private
  
  def admin_params
    params.require(:admin).permit(:email,:password,:password_confirmation)
  end
  
end