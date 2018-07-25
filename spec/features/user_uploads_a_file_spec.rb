require 'rails_helper'

feature 'User upload a csv File' do
  scenario 'successfully' do
    user = create(:user)
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')

    
    login_as(user, scope: :user)
    visit root_path
    
    click_link t('send_file')
    
    attach_file file
    
    expect(page).to have_css('th', text: 'name')
    expect(page).to have_css('th', text: 'Token')
    expect(page).to have_css('th', text: 'Email')
    expect(page).to have_css('th', text: 'Data de admissão')
    expect(page).to have_css('th', text: 'Valor disponível')
    
    CSV.foreach(file, col_sep: ',') do |line|
      line.each do |data|
        expect(page).to have_css('td', text: data)
      end
    end
    
    
  end
end
