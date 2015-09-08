class Api::PostersController < Api::ApplicationController

  def index    
    @posters = Poster.all.order('id desc')
  end

end