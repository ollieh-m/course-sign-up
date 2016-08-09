require 'rails_helper'

feature 'Someone rsvps with their email address to attend a course' do

  before do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,13))
    allow(RestClient).to receive(:post)
  
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-14',end_date:'2001-02-15')
  end
    
  scenario 'successfully, and the course has that attendee as the only unconfirmed attendee' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    course_sign_up(email: 'attendee@email.com', date_of_birth: '1986-05-26')
    click_on('Admin')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    click_on('testname')
    
    expect(page).to have_css('.unconfirmed-attendees li', text: 'attendee@email.com')
  end
  
  scenario 'unsuccessfully, without giving an email address' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    course_sign_up(email: '', date_of_birth: '1986-05-26')
    
    expect(page).to have_content("Email can't be blank")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
  scenario 'unsuccessfully, with invalid email address' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    course_sign_up(email: 'attendee@email', date_of_birth: '1986-05-26')

    expect(page).to have_content("You must enter a valid email")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
  scenario 'unsuccessfully, without giving a DOB' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    course_sign_up(email: 'attendee@email.com', date_of_birth: '')

    expect(page).to have_content("Date of birth can't be blank")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
end