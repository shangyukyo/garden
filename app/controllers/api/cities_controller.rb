class Api::CitiesController < Api::ApplicationController

  def index    
    @cities = City.all      
  end

  def show
    begin
      @city = City.find params[:id]      
    rescue => e      
      error e.inspect
    end
  end



end