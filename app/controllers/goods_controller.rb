class GoodsController < ApplicationController
  before_action :find_good, only: [:show, :new_good_spec, :create_good_spec]

  def index
  end

  def show
  end

  def new
    @categories = Category.all
  end

  def create
    begin
      @categories = Category.where(id: params[:category_ids].split(','))
      @good = Good.new
      @good.name = params[:name]
      @good.description = params[:description]
      @good.save!

      @good.categories = @categories

      render json: {success: true, data: @good}
    rescue => e
      render json: {success: false, error: e.inspect}
    end
  end

  def new_good_spec
    
  end

  def create_good_spec
    begin
      good_spec = @good.good_specs.build
      good_spec.name  = params[:name]
      good_spec.price = params[:price]
      good_spec.origin_price = params[:price]
      good_spec.photo_asset_ids = params[:photo_asset_ids]
      good_spec.save!

      render json: {success: true, data: good_spec}
    rescue => e      
      render json: {success: false, error: e.inspect}
    end
  end

  def edit
  end

  def update
  end


  private

  def find_good
    @good = Good.find params[:id]
  end
end
