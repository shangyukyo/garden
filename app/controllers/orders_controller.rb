class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :delivery, :finish]

  def index
    pagination    
    @orders = Order.all.order('id desc')

    if params[:order_no].present?
      @orders = @orders.where(order_no: params[:order_no])
    end

    if params[:warehouse_name].present?
      @orders = @orders.where("ext like ?", "%#{params[:warehouse_name]}%")
    end

    if params[:pick_up_code].present?
      @orders = @orders.where("ext like ?", "%#{params[:pick_up_code]}%")
    end

    if params[:start_at].present?
      @orders = @orders.where("created_at > ?", params[:start_at])
    end

    if params[:end_at].present?
      @orders = @orders.where("created_at < ?", params[:end_at])
    end

    if params[:status].present?
      @orders  = @orders.try(params[:status].to_sym)
    end

    @total = @orders.size

    @total_goods = OrderGood.where(order_id: @orders.map(&:id)).select("*, sum(quantity) as quantity").group(:good_id)

    respond_to do |format|
      format.xls{
        send_data(xls_content_for(@orders, @total_goods),
                  type: "text/excel;charset=utf-8; header=present",  
                  filename: "Orders_#{Time.now.strftime("%Y%m%d%H%M")}.xls"
                  )
      }

      @orders = @orders.offset(@o).limit(@per_page)   
      format.html
    end

    
  end

  def show
    puts @order.inspect
    @order_goods = @order.order_goods
    puts @order_goods.inspect
  end

  def delivery
    @order.deliver!
    redirect_to :back
  end

  def finish
    @order.finish!
    redirect_to :back
  end


  private

  def find_order
    @order = Order.find(params[:id])
  end

  # def csv_content_for(orders)
  #   FasterCSV.generate do |csv|  
  #     csv << ["订单编号", "提货点", "提货码", "订单状态", "下单时间"]  
    
  #     orders.each do |order|  
  #       csv << [
  #         order.order_no,
  #         order.warehouse.try(:name) || "无",
  #         order.pick_up_code,
  #         order.status_i18n,
  #         order.created_at.strftime('%F %T')
  #       ]  

  #       csv << ["产品名称", "产品价格", "产地", "数量"]

  #       order.goods.each do |good|
  #         csv << [
  #           good.name,
  #           "#{good.price} / #{good.unit}",
  #           good.address,
  #           good.quantity
  #         ]
  #       end
  #     end  
    
  #   end 
  # end

  def xls_content_for(orders, groups)  
    xls_report = StringIO.new  
    book = Spreadsheet::Workbook.new  
    sheet1 = book.create_worksheet :name => "orders"  
      
    red = Spreadsheet::Format.new :color => :red, :weight => :bold, :size => 12

    blue = Spreadsheet::Format.new :color => :blue, :weight => :normal, :size => 12

    order_title_row = 0
    order_count_row = 1

    orders.each do |order|  
      sheet1.row(order_title_row).default_format = red  
      
      sheet1.row(order_title_row).concat ["订单编号", "提货点", "提货码", "订单状态", "下单时间"]        

      sheet1[order_count_row,0]=order.order_no
      sheet1[order_count_row,1]=order.warehouse.try(:name) || "无",
      sheet1[order_count_row,2]=order.pick_up_code

      sheet1[order_count_row,3]=order.status_i18n
      sheet1[order_count_row,4]=order.created_at.strftime('%F %T')

    
      good_title_row = order_count_row + 1      
      good_count_row = good_title_row + 1

      sheet1.row(good_title_row).default_format = blue
      sheet1.row( good_title_row ).concat ["产品名称", "产品价格", "产地", "数量"]
      order.order_goods.each do |order_good|
        good = order_good.good
        sheet1[good_count_row,0]=good.name
        sheet1[good_count_row,1]= "#{good.price} / #{good.unit}"
        sheet1[good_count_row,2]=good.address
        sheet1[good_count_row,3]=order_good.quantity
      
        good_count_row += 1
      end

      order_count_row += order.order_goods.size + 4
      order_title_row += order.order_goods.size + 4
    end  
    

    sheet2 = book.create_worksheet :name => "group"
    red = Spreadsheet::Format.new :color => :red, :weight => :bold, :size => 12
    
    sheet2.row(0).default_format = red  
    sheet2.row(0).concat ["产品名称", "单价", "产地", "总数"]        
    count_row = 1

    groups.each do |g|
      good = g.good
      sheet2[count_row,0]=good.name
      sheet2[count_row,1]= "#{good.price} / #{good.unit}"
      sheet2[count_row,2]=good.address
      sheet2[count_row,3]=g.quantity

      count_row += 1

    end


    book.write xls_report  
    xls_report.string  
  end   

end
