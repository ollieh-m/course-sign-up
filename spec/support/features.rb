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
  
  def create_course(name:,description:,start_date:,end_date:)
    fill_in('Course name', with: name)
    fill_in('Course description', with: description)
    fill_in('Course start date', with: start_date)
    fill_in('Course end date', with: end_date)
    click_on('Post new course')
  end
  
end