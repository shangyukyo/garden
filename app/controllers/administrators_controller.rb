class AdministratorsController < ApplicationController

  before_action :find_administrator, only: [:edit, :update, :destroy]

  def index
    @administrators = Administrator.all
  end

  def new
  end

  def create
    @administrator = Administrator.new
    @administrator.mobile = params[:mobile]
    @administrator.password = params[:password]
    @administrator.password_confirmation = params[:password]

    if params[:power] == "0"
      @administrator.admin_power = true
    elsif params[:power] == "1"
      @administrator.edit_power = true
    elsif params[:power] == "2"
      @administrator.order_power = true
    end

    if @administrator.save!
      redirect_to administrators_path
    end

  end

  def edit
  end

  def update
    @administrator.mobile = params[:mobile]

    if params[:password].present?
      @administrator.password = params[:password]
      @administrator.password_confirmation = params[:password]
    end

    @administrator.update_attributes admin_power: false, edit_power: false, order_power: false

    if params[:power] == "0"
      @administrator.admin_power = true
    elsif params[:power] == "1"
      @administrator.edit_power = true
    elsif params[:power] == "2"
      @administrator.order_power = true
    end

    if @administrator.save!
      redirect_to administrators_path
    end    

  end

  def destroy
    if @administrator.destroy
      redirect_to administrators_path
    end
  end


  private

  def find_administrator
    @administrator = Administrator.find_by id: params[:id]
  end

end
