class AreasController < ApplicationController

  def index
    pagination
    @cities = City.all    
    @areas = Area.all

    if params[:city].present?
      @areas = Area.where(city: params[:city])
    end

    @total = @areas.size
    @areas = @areas.order('id desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if Area.create(name: params[:name], city: params[:city])
  end

  def destroy
    redirect_to :back if Area.find(params[:id]).destroy
  end
end
