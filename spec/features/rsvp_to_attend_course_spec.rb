require 'rails_helper'

feature 'Someone rsvps with their email address to attend a course' do

  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,13))
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
    fill_in('Email', with: 'attendee@email.com')
    fill_in('Date of birth', with: '1986-05-26')
    click_on('Sign up')
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
    fill_in('Email', with: '')
    fill_in('Date of birth', with: '1986-05-26')
    click_on('Sign up')
    expect(page).to have_content("Email can't be blank")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
  scenario 'unsuccessfully, with invalid email address' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    fill_in('Email', with: 'attendee@email')
    fill_in('Date of birth', with: '1986-05-26')
    click_on('Sign up')
    expect(page).to have_content("You must enter a valid email")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
  scenario 'unsuccessfully, without giving a DOB' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    fill_in('Email', with: 'attendee@email.com')
    fill_in('Date of birth', with: '')
    click_on('Sign up')
    expect(page).to have_content("Date of birth can't be blank")
    expect(Attendee.all.count).to eq 0
    expect(Rsvp.all.count).to eq 0
  end
  
end

#an attendee confirms their rsvp by logging into their email and clicking a secret confirm link unique to that rsvp record, emailed to them - only they can confirm
#the token is generated by the rsvp when it is created, isn't saved in the database, and can only be known by whoever gets the email - it is like the password for logging into the rsvp, a password that no-one can know unless they get the email
#course has many unconfirmed attendees - attendees through the rsvp table where the rsvp status is unconfirmed
#course has many confirmed attendees - attendees through the rsvp table where the rsvp status is confirmed