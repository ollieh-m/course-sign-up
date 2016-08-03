module Features
  
  def create_admin(email:,password:,password_confirmation:)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password_confirmation)
    within(:css,'.form-box') do
      click_on('Create admin')
    end
  end
  
  def admin_login(email:, password:)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    within(:css,'.form-box') do
      click_on('Log in')
    end
  end
  
end