class GoodsController < ApplicationController
  before_action :find_good, only: [:show, :edit, :update, :destroy, :new_good_spec, :create_good_spec]
  before_action :find_good_spec, only: [:edit_good_spec, :update_good_spec]

  def index
    pagination
    @goods = Good.all

    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @goods = category.goods
    end

    if params[:name].present?
      @goods = @goods.where("name like ? ", "%#{params[:name]}%")
    end

    @total = @goods.size
    @categories = @goods.order('id desc').offset(@o).limit(@per_page)       
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

  def edit_good_spec    
  end

  def create_good_spec
    begin
      good_spec = @good.good_specs.build
      good_spec.name  = params[:name]
      good_spec.price = params[:price]
      good_spec.origin_price = params[:price]
      good_spec.description = params[:description]
      good_spec.photo_asset_ids = params[:photo_asset_ids]
      good_spec.save!

      render json: {success: true, data: good_spec}
    rescue => e      
      render json: {success: false, error: e.inspect}
    end
  end

  def update_good_spec
    begin      
      @good_spec.name  = params[:name]
      @good_spec.price = params[:price]
      @good_spec.origin_price = params[:price]
      @good_spec.description = params[:description]
      @good_spec.photo_asset_ids = params[:photo_asset_ids]
      @good_spec.save!

      render json: {success: true, data: @good_spec}
    rescue => e      
      render json: {success: false, error: e.inspect}
    end    
  end

  def edit
    @categories = Category.all
    @self_categories = @good.categories    
  end

  def update
    begin
      @categories = Category.where(id: params[:category_ids].split(','))      
      @good.name = params[:name]
      @good.description = params[:description]
      @good.save!

      @good.categories = @categories

      render json: {success: true, data: @good}
    rescue => e
      render json: {success: false, error: e.inspect}
    end    
  end

  def destroy
    @good.destroy
    @good.good_specs.destroy_all
    redirect_to :back
  end

  def destroy_good_spec
    GoodSpec.find_by(id: params[:good_spec_id]).destroy
    redirect_to :back
  end


  private

  def find_good
    @good = Good.find params[:id]
  end

  def find_good_spec
    @good_spec = GoodSpec.find_by(id: params[:good_spec_id])
  end
end
