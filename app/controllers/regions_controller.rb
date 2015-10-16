class RegionsController < ApplicationController

  def index
    @cities = City.order("id desc")

    if params[:city_id].present?
      @regions = City.find(params[:city_id]).regions.order("id desc")
    else
      @regions = Region.all.order("id desc")
    end
  end

  def new    
  end

  def create
    city = City.find_by id: params[:city]

    region = city.regions.build
    region.name = params[:name]
    region.save!

    redirect_to regions_path
  end

  def destroy
    if Region.find(params[:id]).destroy
      redirect_to regions_path
    end
  end

end
