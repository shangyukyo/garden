class UsersController < ApplicationController

  def index
    pagination

    @users = User.all
    if params[:mobile].present?
      @users = @users.where(mobile: params[:mobile])      
    end

    @total = @users.size
    @users = @users.order('id desc').offset(@o).limit(@per_page)    
  end

  def show
  end
end
