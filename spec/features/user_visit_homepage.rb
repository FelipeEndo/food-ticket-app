require 'rails_helper'

feature 'User visit homepage' do
  scenario 'and see uploaded files' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'original',
                           'dados-19-07-2018.csv')
    user = create(:user)
    datafile = build(:data_file)
    datafile.file.attach(io: File.open(file), filename: File.basename(file))
    datafile.save

    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_css('h4', text: I18n.translate('uploaded_files'))
    expect(page).to have_css('p', text: data_file)
  end

  scenario 'but User its not logged in' do
    visit root_path
    expect(page).to have_current_path new_user_session_path
  end
end
