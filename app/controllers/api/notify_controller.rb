class Api::NotifiesController < Api::ApplicationController

  def alipay
    
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

    logger.info "==========ALIPAY VERIFY=========="
    logger.info Alipay::Notify.verify?(notify_params)

    if not Alipay::Notify.verify?(notify_params)
      return_code = 'error'
    else
      payment.amount = notify_params['total_fee'].to_f

      # rsp = Alipay::Service.single_trade_query({ "trade_no" => payment.gateway_transacation_id }, opts)

      # logger.info "======= ALIPAY PAYMENT QUERY ============"
      # logger.info Hash.from_xml(rsp)

      # rsp = Hash.from_xml(rsp)["alipay"]


      # logger.info rsp

      # payment.amount = notify_params["total_fee"]

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