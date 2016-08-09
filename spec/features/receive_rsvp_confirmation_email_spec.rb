feature 'Someone rsvps to attend a course and receives an email with a confirmation token' do

  before do
    allow(RestClient).to receive(:post)
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(ENV).to receive(:[]).with("MAILER_API").and_return("dummyapi")
    allow(ENV).to receive(:[]).with("MAILER_DOMAIN").and_return("dummydomain")
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
    expect(RestClient).to have_received(:post).with("https://api:dummyapi@api.mailgun.net/v3/dummydomain/messages",
                                              {:from=>"Course admin <mailgun@dummydomain>",
                                              :to=>"attendee@email.com",
                                              :subject => "Confirm your place on the course",
                                              :text => "Please click this link to confirm your place on the course:\nhttp://www.example.com/rsvp_confirmation/1/dummyconfirmationtoken"})
  end
  
end