class Api::NotifiesController < Api::ApplicationController

  def alipay
#{"discount"=>"0.00", "payment_type"=>"1", "subject"=>"test_title", "trade_no"=>"2015101300001000720001603447", "buyer_email"=>"wangchao_lcw50@163.com", "gmt_create"=>"2015-10-13 11:03:52", "notify_type"=>"trade_status_sync", "quantity"=>"1", "out_trade_no"=>"201510109171803397", "seller_id"=>"2088021807444912", "notify_time"=>"2015-10-13 11:03:53", "body"=>"test_des", "trade_status"=>"TRADE_SUCCESS", "is_total_fee_adjust"=>"N", "total_fee"=>"0.01", "gmt_payment"=>"2015-10-13 11:03:52", "seller_email"=>"dashengtianqi@aliyun.com", "price"=>"0.01", "buyer_id"=>"2088002454263727", "notify_id"=>"d125d1f5585c298889b853298f9d997460", "use_coupon"=>"N", "sign_type"=>"RSA", "sign"=>"erlI3xjfYgEYBg+WmLr5oS45i6nBbvMRYE26+0Ridc/ODp+KmdI7abeY+7TkMD/5rfOLRd0IwWUt7hzz9Q3VOU5hagn38yzI7lQgnvmrTUJ235/U0Aa7w7hc25c35U0oXw7Ih8mGcOmCMPSbbfmnJ455axEQPWBeuCXISIuIz1g="}
    
    logger.info "============= ALIPAY ================"
    logger.info params

    notify_params = params.except(*request.path_parameters.keys)

    payment = Payment.find_by(payment_no: notify_params["out_trade_no"])
    payment.gateway_transacation_id = notify_params["trade_no"]

    if payment.notified? && payment.paid?
      render text: 'success'
      return
    end

    opts = { sign_type: 'RSA', key: Alipay.key }

    if not Alipay::Notify.verify?(notify_params)
      return_code = 'error'
    else
      payment.amount = notify_params['total_fee'].to_f

      rsp = Alipay::Service.single_trade_query({ "out_trade_no" => payment.payment_no }, opts)

      logger.info "======= ALIPAY PAYMENT QUERY ============"
      rsp = Hash.from_xml(rsp)["alipay"]
      logger.info rsp

      payment.amount = rsp["response"]["trade"]["total_fee"]      

      if trade_succeed?(notify_params['trade_status'])
        return_code = 'success'
      else
        return_code = 'error'
      end      
    end

    if return_code == 'success'
      payment.notified = true
      payment.save!
      payment.purchase!
    else
      payment.save!
      payment.paid_failed!
    end

    render text: return_code    

  end



  private

  def trade_succeed?(*args)
    state = false
    args.each do |flag|
      if ['SUCCESS', 'TRADE_FINISHED', '0', 0, 'TRADE_SUCCESS'].include?(flag)
        state = true and break
      else
        next
      end
    end
    
    return state
  end  

end