require 'rails_helper'

RSpec.describe DataFile, type: :model do
  it 'should have expected file header content' do
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')
    
    expect(header).to eq(CSV.read(file, headers:true).headers)
  end
  
  it 'should have expected file content' do
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    file = Rails.root.join('public',
                            'test_files',
                            'dados-19-07-2018.csv')
    
    CSV.read(file, headers:true).each do |line|
      expect(line.count).to eq(header.count)
      expect(line[0].class).to eq(String) # [a-zA-Z]+g
      expect(line[1].class).to eq(String) # [a-zA-Z]+g
      expect(line[2].class).to eq(String) # \b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z
      expect(line[3].class).to eq(String) # ^[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}$
      expect(line[4].class).to eq(String) # ^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$
      expect(line[5].class).to eq(String) # ^\d\d\d$
    end
    
  end
end
