class PartitionsController < ApplicationController
  before_action :find_partition, only: [:edit, :update, :switch_display, :destroy]

  def index
    pagination

    @partitions = Category.partition
    @total = @partitions.size
    @partitions = @partitions.order('queue desc').offset(@o).limit(@per_page)    
  end

  def new
  end

  def create
    params.permit!
    category = Category.new
    category.name = params[:name]
    category.category_type = Category.category_types[:partition]
    category.queue = params[:queue]
    category.asset_id = params[:asset_id]
    category.save!
    redirect_to partitions_path    

  end

  def edit
  end

  def update
    params.permit!
    redirect_to partitions_path if @partition.update_attributes(name: params[:name], queue: params[:queue], asset_id: params[:asset_id])
  end

  def switch_display
    @partition.show? ? @partition.hidden! : @partition.show!
    redirect_to :back
  end  

  def destroy
    redirect_to :back if @partition.destroy
  end  

  private

  def find_partition
    @partition = Category.find(params[:id])
  end

end
