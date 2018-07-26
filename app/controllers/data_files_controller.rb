class DataFilesController < ApplicationController
  require 'csv'
  def create
    @data_file = DataFile.new(data_file_params)
    if @data_file.save
      redirect_to @data_file
    else
      redirect_to root_path
    end
  end
  
  def show
    @file = DataFile.find(params[:id]).file
    @header = replace_name_and_surname(@file.download).first
    @file_content = replace_name_and_surname(@file.download)
  end
  
  private
  def data_file_params
    params.require(:data_file).permit(:file)
  end
  
  def replace_name_and_surname(file)
    CSV.parse(file).each_with_index do |line, index|
      if index > 0
        line[0] = [line[0], line[1]].join(' ')
      end
      line.delete_at(1)
    end
  end

end
