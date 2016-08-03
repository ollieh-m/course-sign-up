require 'bcrypt'

class Admin < ActiveRecord::Base
    
  include AdminValidations
  include ErrorsHandler
  include BCrypt
  
  def validate_then_save(admin_params)
    if validated(admin_params)
      set_password_hash(admin_params[:password]).save
    end
  end
  
  def authenticate(submitted_password)
    my_password = BCrypt::Password.new(self.password_hash)
    my_password == submitted_password
  end
  
  private
  
  def set_password_hash(new_password)
    password = BCrypt::Password.create(new_password)
    self.tap do |admin|
      admin.password_hash = password
    end
  end
  
end
