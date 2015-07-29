class SchoolsController < ApplicationController

  def index
    pagination
    @cities = City.all    
    @schools = School.all

    if params[:city].present?
      @schools = School.where(city: params[:city])
    end

    @total = @schools.size
    @schools = @schools.order('id desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if School.create(name: params[:name], city: params[:city])
  end

  def destroy
    redirect_to :back if School.find(params[:id]).destroy
  end
end
