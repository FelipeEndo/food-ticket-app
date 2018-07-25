require 'rails_helper'

feature 'User upload a csv File' do
  scenario 'successfully' do
    user = create(:user)
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')

    
    login_as(user, scope: :user)
    visit root_path
    
    attach_file file
    click_button I18n.translate('send_file')
    
    expect(page).to have_current_path data_file_path DataFile.first
    
    expect(page).to have_css('h3', text: "Arquivo: #{File.basename(file, ".*")}")
    expect(page).to have_css('h4', text: "Número de Linhas: #{CSV.read(file).count - 1}")

    expect(page).to have_css('th', text: 'name')
    expect(page).to have_css('th', text: 'surname')
    expect(page).to have_css('th', text: 'email')
    expect(page).to have_css('th', text: 'token')
    expect(page).to have_css('th', text: 'admission_date')
    expect(page).to have_css('th', text: 'available_amount')
    
    CSV.foreach(file).with_index do |line, index|
      line.each do |data|
        if index > 0
         expect(page).to have_css('td', text: data)
        end
      end
    end
    
    
  end
end
