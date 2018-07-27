require 'rails_helper'
require 'csv'

RSpec.describe DataFile, type: :model do
  it 'ensures expected file content' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'wrong_content',
                           'dados-01-01-2001.csv')
    
    data = DataFile.new()
    data.file.attach(io: File.open(file), filename: File.basename(file))
    result = data.save
    expect(result).to eq(false)
    expect(data.errors.full_messages)
      .to eq(["File #{I18n.translate('wrong_file_content')}"])
  end
  
  it 'ensures expected file header' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'wrong_header',
                           'dados-02-02-2002.csv')
    
    data = DataFile.new()
    data.file.attach(io: File.open(file), filename: File.basename(file))
    result = data.save
    expect(result).to eq(false)
    expect(data.errors.full_messages).to eq(["File #{I18n.translate('wrong_content_header')}"])
  end
  
  it 'ensures expected filename format' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'wrong_file_format',
                           'dados-sem-data.csv')
    
    data = DataFile.new()
    data.file.attach(io: File.open(file), filename: File.basename(file))
    result = data.save
    expect(result).to eq(false)
    expect(data.errors.full_messages)
      .to eq(["File #{I18n.translate('wrong_filename_format')}"])
  end
  
  it 'ensures expected file extension' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'wrong_file_extension',
                           'dados-02-02-2002.pdf')
    
    data = DataFile.new()
    data.file.attach(io: File.open(file), filename: File.basename(file))
    result = data.save
    expect(result).to eq(false)
    expect(data.errors.full_messages)
      .to eq(["File #{I18n.translate('wrong_filename_extension')}"])
  end
  
  it 'saves with all correct configs' do
    file = Rails.root.join('spec',
                           'shared',
                           'test_files',
                           'original',
                           'dados-19-07-2018.csv')
    
    data = DataFile.new()
    data.file.attach(io: File.open(file), filename: File.basename(file))
    result = data.save
    expect(result).to eq(true)
  end
end
