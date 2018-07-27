class FileMetaValidator < ActiveModel::Validator
  require 'csv'
  NAME = '^[a-zA-Z]+$'
  SURNAME = '^[a-zA-Z]+$'
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
  FILE_FORMAT = '\G(dados)-[0-3]\d-[0-1]\d-[1-2][09]\d\d'

  def validate(record)
    unless file_match?(record.file)
      record.errors[:file] << I18n.translate('wrong_file_content')
    end
    
    unless header_match?(record.file)
      record.errors[:file] << I18n.translate('wrong_content_header')
    end
    
    unless regex_match?(record.file.filename.to_s, FILE_FORMAT)
      record.errors[:file] << I18n.translate('wrong_filename_format')
    end
    
    unless record.file.filename.to_s.end_with?('.csv')
      record.errors[:file] << I18n.translate('wrong_filename_extension')
    end
  end
  
  def file_match?(file)
    regex_hash = [NAME, SURNAME, EMAIL, TOKEN, ADMISSION_DATE, AMOUNT]
    CSV.parse(file.download, headers:true).each do |line|
      line.each_with_index do |row, index|
        return false unless regex_match?(line[index], regex_hash[index])
      end
    end
  end
  
  def header_match?(file)
    header = ["name", "surname", "email", "token", "admission_date", "available_amount"]
    header.eql? CSV.parse(file.download).first 
  end
  
  def regex_match?(string, regex)
    string.match Regexp.new(regex)
  end
end