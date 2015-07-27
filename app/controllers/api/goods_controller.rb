class Api::GoodsController < Api::ApplicationController

  def index
    begin      
      category = Category.find params[:category_id]
      goods = category.goods.published
      render_json goods
    rescue => e
      error e
    end
  end

  def show
    begin
      good = Good.find params[:id]
      good_specs = good.good_specs

      good_specs.each do |spec|
        spec.photo_urls = Asset.where(id: self.photo_asset_ids.split(',')).map{|a| a.resource_url(:large)}
      end

      render_json({good: good, good_specs: good_specs})
    rescue => e
      error e
    end
  end

end