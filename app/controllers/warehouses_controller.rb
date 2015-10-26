class WarehousesController < ApplicationController

  before_action :find_warehouse, only: [:edit, :update, :destroy]

  def index
    pagination
    @warehouses = Warehouse.all

    @total = @warehouses.size
    @warehouses = @warehouses.order('id desc').offset(@o).limit(@per_page)        
  end

  def new
  end

  def create
    region = Region.find params[:region]

    warehouse = region.warehouses.build
    warehouse.name = params[:name]
    warehouse.business_time = params[:business_time]
    warehouse.address = params[:address]
    warehouse.longitude = params[:longitude]
    warehouse.latitude = params[:latitude]
    warehouse.tel = params[:tel]
    warehouse.content = params[:content]    
    warehouse.url = params[:url]
    warehouse.save!

    redirect_to warehouses_path
  end

  def edit
  end

  def update
    @warehouse.name = params[:name]
    @warehouse.business_time = params[:business_time]
    @warehouse.address = params[:address]
    @warehouse.longitude = params[:longitude]
    @warehouse.latitude = params[:latitude]    
    @warehouse.tel = params[:tel]
    @warehouse.content = params[:content]
    @warehouse.url = params[:url]
    @warehouse.region_id = params[:region]
    @warehouse.save!

    redirect_to warehouses_path    
  end

  def destroy
    redirect_to warehouses_path if @warehouse.destroy
  end

  private

  def find_warehouse
    @warehouse = Warehouse.find_by id: params[:id]
  end

end
