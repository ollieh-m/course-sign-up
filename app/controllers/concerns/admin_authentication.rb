module AdminAuthentication
    
  def check_admin_is_signed_in
    if Admin.all.empty?
      redirect_to new_admin_path
    end
  end
  
end