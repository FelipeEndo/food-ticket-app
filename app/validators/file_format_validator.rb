class FileFormatValidator < ActiveModel::Validator
  def validate(record)
    unless record.file.filename.to_s.match(/\G(dados)-[0-3]\d-[0-1]\d-[1-2][09]\d\d/)
      record.errors[:file] << I18n.translate('wrong_filename_format')
    end
  end
end
 
