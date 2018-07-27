require 'rails_helper'
require 'csv'

RSpec.describe DataFile, type: :model do
  it 'should have expected file header content' do
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')
    
    expect(header).to eq(CSV.read(file, headers:true).headers)
  end
  
  it 'should have expected file content' do
    NAME = '^[a-zA-Z]+$'
    EMAIL = '^\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z$'
    TOKEN = '^[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-'\
            '[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}$'
    ADMISSION_DATE = '^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)'\
                     '(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?'\
                     '\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?'\
                     '(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|'\
                     '[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)'\
                     '(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$'
    AMOUNT = '^[0-9]+$'
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')
    fakefile = Rails.root.join('public',
                            'test_files',
                            'fakedados.csv')
    
    CSV.read(file, headers:true).each do |line|
      expect(line.count).to eq(header.count)
      expect(regex_match(line[0], NAME)).to be_truthy
      expect(regex_match(line[1], NAME)).to be_truthy
      expect(regex_match(line[2], EMAIL)).to be_truthy
      expect(regex_match(line[3], TOKEN)).to be_truthy
      expect(regex_match(line[4], ADMISSION_DATE)).to be_truthy
      expect(regex_match(line[5], AMOUNT)).to be_truthy
    end
    
    CSV.read(fakefile, headers:true).each do |line|
      expect(regex_match(line[0], NAME)).to be_nil
      expect(regex_match(line[1], NAME)).to be_nil
      expect(regex_match(line[2], EMAIL)).to be_nil
      expect(regex_match(line[3], TOKEN)).to be_nil
      expect(regex_match(line[4], ADMISSION_DATE)).to be_nil
      expect(regex_match(line[5], AMOUNT)).to be_nil
    end
    
  end
end
