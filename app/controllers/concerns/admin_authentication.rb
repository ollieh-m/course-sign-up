module AdminAuthentication
  
  include AdminAuthenticationHelper
    
  def check_admin_is_signed_in
    if Admin.all.empty?
      redirect_to new_admin_path
    elsif current_admin.nil?
      redirect_to new_admin_session_path
    end
  end
  
  def check_new_admin_can_be_created
    if current_admin.nil? and Admin.all.count > 0
      flash[:errors] = ['Please sign in as an existing admin']
      redirect_to new_admin_session_path
    end
  end
  
  def sign_in(admin)
    session[:admin_id] = admin.id
  end
  
  def invalid_first_admin(admin_params)
    Admin.all.empty? and env_credentials_do_not_match admin_params
  end
  
  private
  
  def env_credentials_do_not_match(admin_params)
    !(admin_params[:email] == ENV["ADMIN_EMAIL"] and admin_params[:password] == ENV["ADMIN_PASSWORD"])
  end
  
end