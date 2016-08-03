require 'bcrypt'

class Admin < ActiveRecord::Base
    
  include AdminValidations
  include ErrorsHandler
  include BCrypt
  
  def save_if_valid(admin_params)
    if validated(admin_params)
      set_password_hash(admin_params[:password]).save
    end
  end
  
  private
  
  def set_password_hash(new_password)
    password = BCrypt::Password.create(new_password)
    self.tap do |admin|
      admin.password_hash = password
    end
  end
  
end
