class Api::PostersController < Api::ApplicationController

  def index    
    @posters = Poster.all.order('id desc')

    @posters = @posters.map{|p|
      next if not p.good.present?
      p
    }
  end

end