class HomeController < ApplicationController
  def index
    @data_file = DataFile.new
    @all_data_files = DataFile.all
  end
end
