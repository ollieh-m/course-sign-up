require 'rails_helper'

feature 'First admin signs up then signs out' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
  end
  
  scenario 'and can sign back in' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    click_on('Sign out')
    click_on('Admin')
    admin_login(email: 'test@email.com',password: 'testpassword')
    expect(current_path).to eq admin_home_path
    expect(page).to have_content('ADMIN HOMEPAGE - test@email.com')
  end
  
end