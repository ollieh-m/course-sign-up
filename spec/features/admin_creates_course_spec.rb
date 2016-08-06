require 'rails_helper'

feature 'Admin creates a course' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,3))
  end
  
  scenario 'and it is visible on the home courses page' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    fill_in('Course name', with: 'testname')
    fill_in('Course description', with: 'testdescription')
    fill_in('Course start date', with: '2/3/2001')
    fill_in('Course end date', with: '6/3/2001')
    click_on('Post new course')
    within(:css, 'nav') do
      click_on('Courses')
    end
    expect(page).to have_content('testname')
  end
  
end