class Api::PartitionsController < Api::ApplicationController

  def index
    @partitions = Category.partition.show.order('queue desc')            
  end

  def show
    begin
      @partition = Category.find params[:id]      
    rescue => e
      error e.inspect
    end
  end

end