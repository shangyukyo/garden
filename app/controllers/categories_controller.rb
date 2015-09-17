class CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update, :switch_display, :destroy]

  def index
    pagination
    @categories = Category.normal
    @total = @categories.size
    @categories = @categories.order('queue desc').offset(@o).limit(@per_page)    
  end

  def new
  end

  def create
    params.permit!
    category = Category.new
    category.name = params[:name]
    category.category_type = Category.category_types[:normal]
    category.queue = params[:queue]
    category.asset_id = params[:asset_id]
    category.save!
    redirect_to categories_path
  end

  def edit    
  end

  def update
    params.permit!

    redirect_to categories_path if @category.update_attributes(name: params[:name], queue: params[:queue], asset_id: params[:asset_id])
  end

  def switch_display
    @category.show? ? @category.hidden! : @category.show!
    redirect_to :back    
  end

  def destroy
    redirect_to :back if @category.destroy
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

end
