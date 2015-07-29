class PartitionsController < ApplicationController

  def index
    pagination

    @partitions = Category.partition
    @total = @partitions.size
    @partitions = @partitions.order('id desc').offset(@o).limit(@per_page)    
  end

  def create
    params.permit!
    redirect_to :back if Category.create(name: params[:name], category_type: Category.category_types[:partition], queue: params[:queue])
  end

  def destroy
    redirect_to :back if Category.find(params[:id]).destroy
  end  

end
