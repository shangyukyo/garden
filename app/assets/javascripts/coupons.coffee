window.CouponView = Backbone.View.extend
  el: 'body'
  user: ''


  initialize: () ->
    #...



  popupCoupon: (user) ->
    $("#couponsModal").modal()
    this.user = user


  giveCoupon: () ->
    self = this
    console.log self.user

    coupon_id = $("#couponSelect").val()

    $.post '/users/give_coupon', {coupon_id: coupon_id, user: self.user}, (res) ->

      if res.success
        alert '发送成功'    

        $("#couponsModal").modal('toggle')
      else
        alert '发送失败'

    , 'json'



    
               