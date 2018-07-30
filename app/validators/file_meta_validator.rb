class FileMetaValidator < ActiveModel::Validator
  require 'csv'

  def validate(record)
    unless presence_of?(record.file)
      record.errors[:file] << I18n.translate('file_nil')
      return
    end
    
    unless file_match?(record.file)
      record.errors[:file] << I18n.translate('wrong_file_content')
    end
    
    unless header_match?(record.file)
      record.errors[:file] << I18n.translate('wrong_content_header')
    end
    
    unless regex_match?(record.file.filename.to_s,
                        REGEX['expression']['filename_format'])
      record.errors[:file] << I18n.translate('wrong_filename_format')
    end
    
    unless record.file.filename.extension.eql? 'csv'
      record.errors[:file] << I18n.translate('wrong_filename_extension')
    end
  end
  
  def presence_of?(file)
    file.attached?
  end
  
  def file_match?(file)
    regex_hash = [REGEX['expression']['letters_only'],
                  REGEX['expression']['letters_only'],
                  REGEX['expression']['email_format'],
                  REGEX['expression']['token_format'],
                  REGEX['expression']['date_format'],
                  REGEX['expression']['numbers_only']
                  ]
      CSV.parse(file.download, headers:true).each do |line|
        line.each_with_index do |row, index|
          return false unless regex_match?(line[index], regex_hash[index])
        end
      end
  end
  
  def header_match?(file)
    header = ["name", "surname", "email", "token",
              "admission_date", "available_amount"]
    header.eql? CSV.parse(file.download).first 
  end
  
  def regex_match?(string, regex)
    string.match Regexp.new(regex)
  end
end