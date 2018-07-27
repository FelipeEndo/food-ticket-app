class FileExtensionValidator < ActiveModel::Validator
  def validate(record)
    unless record.file.filename.to_s.end_with?('.csv')
      record.errors[:file] << I18n.translate('wrong_filename_extension')
    end
  end
end
 
