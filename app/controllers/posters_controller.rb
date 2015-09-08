class PostersController < ApplicationController

  def index
    pagination
    @posters = Poster.all
    @total = @posters.size
    @posters = @posters.order('id desc').offset(@o).limit(@per_page)
  end

  def create
    params.permit!

    if not Good.find_by(id: params[:good_id]).present?      
      redirect_to :back, alert: '此商品不存在' and return
    end

    if not Asset.find_by(id: params[:asset_id]).present?
      redirect_to :back, alert: '图片不能为空' and return      
    end

    poster = Poster.new
    poster.asset_id = params[:asset_id]
    poster.good_id = params[:good_id]
    poster.save!

    redirect_to posters_path
  end

  def good_info
    good = Good.find_by(id: params[:good_id])
    render json: {success: good.present?, good_name: good.try(:name)}
  end

  def destroy
    redirect_to :back if Poster.find(params[:id]).destroy
  end
end
