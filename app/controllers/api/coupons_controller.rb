class Api::CouponsController < Api::ApplicationController

  def index
    authenticate!
    @coupons = @current_user.coupons.effect_coupons.order('id desc')
  end
  
end