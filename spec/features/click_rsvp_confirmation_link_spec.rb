feature 'Someone rsvps to attend a course, receives an email with a confirmation token and clicks to confirm' do

  before do
    allow(RestClient).to receive(:post)
    allow(ENV).to receive(:[])
    
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,13))
    allow(SecureRandom).to receive(:urlsafe_base64).and_return('dummyconfirmationtoken')
    
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-14',end_date:'2001-02-15')
  end
  
  scenario 'successfully' do
    within(:css, 'nav') do
      click_on('Courses')
    end
    click_on('RSVP')
    course_sign_up(email: 'attendee@email.com', date_of_birth: '1986-05-26')
    visit 'http://www.example.com/rsvp_confirmation/1/dummyconfirmationtoken'
    click_on('Admin')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    click_on('testname')
    expect(page).not_to have_css('.unconfirmed-attendees li', text: 'attendee@email.com')
    expect(page).to have_css('.confirmed-attendees li', text: 'attendee@email.com')
  end
  
end