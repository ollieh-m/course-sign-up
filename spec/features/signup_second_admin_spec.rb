feature 'Admin signs up a second admin' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
  end
  
  scenario 'successfully, after signing in' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Create admin')
    create_admin(email: 'test2@email.com', password: 'test2password', password_confirmation: 'test2password')
    expect(page).to have_content('test2@email.com admin account created')
    click_on('Sign out')
    click_on('Admin')
    admin_login(email: 'test2@email.com', password: 'test2password')
    expect(page).to have_content('ADMIN HOMEPAGE - test2@email.com')
  end
  
  scenario 'unsuccessfully, having signed out' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Sign out')
    visit new_admin_path
    expect(current_path).to eq new_admin_session_path
  end
  
  scenario 'unsuccessfully, with invalid email' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Create admin')
    create_admin(email: 'test2@email', password: 'test2password', password_confirmation: 'test2password')
    expect(page).to have_content('You must enter a valid email')
    expect(Admin.all.count).to eq 1
  end
  
  scenario 'unsuccessfully, with password confirmation not matching' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Create admin')
    create_admin(email: 'test2@email.com', password: 'test2password', password_confirmation: 'test3password')
    expect(page).to have_content("Password confirmation doesn't match")
    expect(Admin.all.count).to eq 1
  end
  
  scenario 'unsuccessfully, with no password' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Create admin')
    create_admin(email: 'test2@email.com', password: '', password_confirmation: '')
    expect(page).to have_content("Password can't be blank")
    expect(Admin.all.count).to eq 1
  end
  
end