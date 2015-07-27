class PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def handler    
    asset = Asset.new
    asset.resource = params[:resource]

    if asset.save
      render json: {success: true, data: asset}
    else
      render json: {success: false, data: asset.errors.full_messages}
    end
  end

end
