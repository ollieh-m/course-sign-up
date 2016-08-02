feature 'Admin signs in using ENV credentials' do
  
  scenario 'successfully' do
    allow(ENV).to receive(:[]).with("ADMIN_PASSWORD").and_return("testpassword")
    allow(ENV).to receive(:[]).with("ADMIN_EMAIL").and_return("testemail")
    visit root_path
    click('Admin sign-in')
    fill_in('Email', with: 'testemail')
    fill_in('Password', with: 'testpassword')
    click('Sign in')
    expect(page).to have_css('h1', text: 'ADMIN DASHBOARD')
  end
  
end