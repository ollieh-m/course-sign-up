require 'rails_helper'

feature 'Signed up admin can sign in' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Sign out')
  end
  
  scenario 'with the correct credentials' do
    click_on('Admin')
    admin_login(email: 'test@email.com', password: 'testpassword')
    expect(page).to have_content('ADMIN HOMEPAGE - test@email.com')
  end
  
  scenario 'with the wrong password' do
    click_on('Admin')
    admin_login(email: 'test@email.com', password: 'test2password')
    expect(page).not_to have_content('ADMIN HOMEPAGE - test@email.com')
    expect(page).to have_content('Those credentials are invalid')
  end
  
  scenario 'with the wrong email address' do
    click_on('Admin')
    admin_login(email: 'test2@email.com', password: 'testpassword')
    expect(page).not_to have_content('ADMIN HOMEPAGE - test@email.com')
    expect(page).to have_content('Those credentials are invalid')
  end
  
end