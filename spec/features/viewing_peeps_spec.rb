feature 'Viewing peeps' do
  let(:user) do
    User.create(username: 'Teeohbee',
                name: 'Toby Clarke',
                password: '12345678',
                email: 'toby@example.com',
                password_confirmation: '12345678')
  end

  scenario ' I can see existing peeps on the main page' do
    sign_in(user)
    user.peeps.create(message: 'Test message')
    visit '/peeps'
    expect(page.status_code).to eq 200
    within 'ul#peeps' do
      expect(page).to have_content('Test message')
    end
  end

  scenario ' I can see time stamps on peeps' do
    Peep.create(message: 'Test message', time: '14:11')
    visit '/peeps'
    expect(page.status_code).to eq 200
    within 'ul#peeps' do
      expect(page).to have_content('14:11')
    end
  end

  def sign_in(user)
    visit '/sessions/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end
end
