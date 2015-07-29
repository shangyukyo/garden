class CitiesController < ApplicationController

  def index
    pagination
    @cities = City.all
    @total = @cities.size
    @cities = @cities.order('id desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if City.create(name: params[:name])
  end

  def destroy
    redirect_to :back if City.find(params[:id]).destroy
  end
end
