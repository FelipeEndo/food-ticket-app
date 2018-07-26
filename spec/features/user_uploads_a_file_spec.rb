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
    expect(page).to have_css('h4', text: "Número de Linhas: #{CSV.read(file).count}")

    expect(page).to have_css('th', text: I18n.translate('name'), count: 2)
    expect(page).not_to have_css('th', text: I18n.translate('surname'))
    expect(page).to have_css('th', text: I18n.translate('email'), count: 2)
    expect(page).to have_css('th', text: I18n.translate('token'), count: 2)
    expect(page).to have_css('th', text: I18n.translate('admission_date'), count: 2)
    expect(page).to have_css('th', text: I18n.translate('available_amount'), count: 2)
    
    expect(page).to have_css('h3', text: 'Older Employees')
    
    older_employees(replace_name_and_surname(CSV.read file)).each_with_index do |line, index|
      line.each do |data|
        if index > 0
         expect(page).to have_css('table.older_employees td', text: data)
        end
      end
    end
    
    expect(page).to have_css('h3', text: 'Newer Employees')
    
    newer_employees(replace_name_and_surname(CSV.read file)).each_with_index do |line, index|
      line.each do |data|
        if index > 0
         expect(page).to have_css('table.newer_employees td', text: data)
        end
      end
    end
  end

  scenario 'but filename its not in proper format' do
    user = create(:user)
    file = Rails.root.join('public',
                            'test_files',
                            'dados-sem-data.csv')

    
    login_as(user, scope: :user)
    visit root_path
    
    attach_file file
    click_button I18n.translate('send_file')
    
    expect(page).to have_css('li', text: I18n.translate('wrong_file_format'))
  end
  
  scenario 'but filename its not in proper extension' do
    user = create(:user)
    file = Rails.root.join('public',
                            '404.html')

    
    login_as(user, scope: :user)
    visit root_path
    
    attach_file file
    click_button I18n.translate('send_file')
    
    expect(page).to have_css('li', text: I18n.translate('wrong_file_extension'))
  end
  
  scenario 'but file has not right content' do
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')
    
    header.eql? CSV.read(file, headers:true).headers
    
  end
end
