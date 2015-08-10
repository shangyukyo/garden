class PartitionsController < ApplicationController
  before_action :find_partition, only: [:update, :switch_display, :destroy]

  def index
    pagination

    @partitions = Category.partition
    @total = @partitions.size
    @partitions = @partitions.order('queue desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if Category.create(name: params[:name], category_type: Category.category_types[:partition], queue: params[:queue].to_i)
  end

  def update
    params.permit!
    redirect_to :back if @partition.update_attributes(name: params[:name], queue: params[:queue])
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
