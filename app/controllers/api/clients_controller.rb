class Api::ClientsController < Api::ApplicationController

  def show    
    render json: {version: "1.0", msg: "", url: "http://www.chengselife.com"}     
  end

end