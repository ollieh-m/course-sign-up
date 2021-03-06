require 'rails_helper'

feature 'First admin signs up' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
  end
  
  scenario 'successfully, using ENV credentials' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    expect(current_path).to eq admin_home_path
    expect(page).to have_content('ADMIN HOMEPAGE - test@email.com')
  end
  
  scenario 'unsuccessfully, not using ENV credentials' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'wrong@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    expect(current_path).to eq new_admin_path
    expect(page).not_to have_content('ADMIN HOMEPAGE - wrong@email.com')
  end
  
end

