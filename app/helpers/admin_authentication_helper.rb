module AdminAuthenticationHelper

  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find(session[:admin_id])
    end
  end
  
end