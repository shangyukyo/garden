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

  def search
    begin
      @city = City.where("name like ?", "%#{params[:name]}%").first
      raise "未匹配到城市" if not @city.present?
    rescue => e
      error e.inspect
    end
  end


end