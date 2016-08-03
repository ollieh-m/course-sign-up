module AdminValidations
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  def validated(admin_params)
    validate_email(admin_params[:email])
    validate_password(admin_params[:password],admin_params[:password_confirmation])
    valid_status
  end
  
  def validate_email(email_address)
    if email_address =~ VALID_EMAIL_REGEX
      validate_email_uniqueness(email_address)
    else
      add_error('You must use a valid email address')
    end
  end
  
  def validate_email_uniqueness(email_address)
    if Admin.exists?(email: email_address)
      add_error('The email address is already taken')
    end
  end
  
  def validate_password(password,password_confirmation)
    if password != ""
      validate_password_confirmation(password, password_confirmation)
    else
      add_error('You must choose a password')
    end
  end
  
  def validate_password_confirmation(password, password_confirmation)
    unless password == password_confirmation
      add_error('The password confirmation does not match the password')
    end
  end
  
end