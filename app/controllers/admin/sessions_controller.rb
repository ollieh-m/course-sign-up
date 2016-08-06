class Admin::SessionsController < ApplicationController
  
  include AdminAuthentication
  
  def destroy
    session[:admin_id] = nil
    redirect_to root_path
  end
  
  def new
  end
  
  def create
    admin = Admin.find_by(email: session_params[:email])
    if admin && admin.authenticate(session_params[:password])
      sign_in(admin)
    else
      flash[:errors] = ['Those credentials are invalid']
      redirect_to new_admin_session_path
    end
  end
  
  private 
  
  def session_params
    params.require(:session).permit(:email,:password)  
  end
  
end