require 'rails_helper'

feature 'Admin creates a course' do
  
  before do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("test@email.com")
    allow(DateTime).to receive(:now).and_return(DateTime.new(2001,2,13))
  end
  
  scenario 'successfully, and it is visible on the home courses page' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-14',end_date:'2001-02-15')
    within(:css, 'nav') do
      click_on('Courses')
    end
    expect(page).to have_content('testname')
  end
  
  scenario 'though a non-admin cannot' do
    visit root_path
    visit admin_courses_path
    expect(current_path).to eq new_admin_path
  end
  
  scenario 'unsuccessfully with no name' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'',description:'testdescription',start_date:'2001-02-14',end_date:'2001-02-15')
    expect(page).to have_content("Name can't be blank")
    expect(Course.all.count).to eq 0
  end
  
  scenario 'unsuccessfully with no start date' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'',end_date:'2001-02-15')
    expect(page).to have_content("Start can't be blank")
    expect(Course.all.count).to eq 0
  end
  
  scenario 'unsuccessfully with no end date' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-14',end_date:'')
    expect(page).to have_content("End can't be blank")
    expect(Course.all.count).to eq 0
  end
  
  scenario 'unsuccessfully with start date in the past' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-12',end_date:'2001-02-15')
    expect(page).to have_content('Course must start in the future')
    expect(Course.all.count).to eq 0
  end
  
  scenario 'unsuccessfully start date after end date' do
    visit root_path
    click_on('Admin')
    create_admin(email: 'test@email.com', password: 'testpassword', password_confirmation: 'testpassword')
    within(:css, '.admin-menu') do
      click_on('Courses')
    end
    create_course(name:'testname',description:'testdescription',start_date:'2001-02-15',end_date:'2001-02-14')
    expect(page).to have_content('Course must end after it starts!')
    expect(Course.all.count).to eq 0
  end

end