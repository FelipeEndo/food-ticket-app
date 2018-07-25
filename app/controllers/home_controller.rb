class HomeController < ApplicationController
    def index
      @data_file = DataFile.new
    end
end