require 'rails_helper'

feature 'First admin signs up using ENV credentials' do
  
  scenario 'successfully' do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("testemail")
    visit root_path
    click_on('Admin')
    fill_in('Email', with: 'testemail')
    fill_in('Password', with: 'testpassword')
    fill_in('Password confirmation', with: 'testpassword')
    click_on('Create admin')
    expect(current_path).to eq admin_home_path
    expect(page).to have_css('h1', text: 'ADMIN HOMEPAGE')
  end
  
end