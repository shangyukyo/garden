class Api::UsersController < Api::ApplicationController

  def send_verfiy_code 
  end

  def lu
    authenticate!    
    render_json Lu::Province.build_related_city_region
  end


end