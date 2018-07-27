class DataFile < ApplicationRecord
  has_one_attached :file
  
  validates_with FileFormatValidator, FileExtensionValidator, FileContentValidator
    
end
