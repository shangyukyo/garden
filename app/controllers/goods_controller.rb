class GoodsController < ApplicationController
  before_action :find_good, only: [:show, :edit, :update, :destroy, :new_good_spec, :create_good_spec]  

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
    @goods = @goods.order('id desc').offset(@o).limit(@per_page)       
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
      @good.origin_price = params[:price]
      @good.price = params[:price]
      @good.unit = params[:unit]
      @good.address = params[:address]
      @good.description = params[:description]
      @good.photo_asset_ids = params[:photo_asset_ids]   
      @good.partition_photo = params[:partition_photo]   
      @good.save!

      @good.published!

      @good.categories = @categories

      render json: {success: true, data: @good}
    rescue => e
      raise e
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
      @good.origin_price = params[:price]
      @good.price = params[:price]      
      @good.unit = params[:unit]
      @good.address = params[:address]      
      @good.description = params[:description]
      @good.photo_asset_ids = params[:photo_asset_ids]   
      @good.partition_photo = params[:partition_photo]      
      @good.save!

      @good.categories = @categories

      render json: {success: true, data: @good}
    rescue => e
      render json: {success: false, error: e.inspect}
    end    
  end

  def destroy
    @good.destroy
    redirect_to :back
  end


  private

  def find_good
    @good = Good.find params[:id]
  end

end
