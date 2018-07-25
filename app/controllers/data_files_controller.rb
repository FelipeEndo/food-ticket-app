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
    @file_data = CSV.parse(@file.download, headers: true)
  end
  
  private
  def data_file_params
    params.require(:data_file).permit(:file)
  end
end