window.GoodView = Backbone.View.extend
  el: '.goods'
  
  events: {
    'click .categories span.label-category': 'checkCategory'
    'mouseover .categories span.label-category' : 'handCategory'
    'click a.createGoodsBtn' : 'createGoods'
    'click a.updateGoodsBtn' : 'updateGoods'
    'click a.remove-img' : 'removeImg'
  }

  initialize: () ->
    $('#resource').fileupload
      forceIframeTransport: true,
      autoUpload: true,    
      dataType: 'json'
      url: '/photos/handler'
      done: (e, data) ->
        response = data.result
        if response.success
          $img = "<div class='img-panel col-xs-1 col-md-1'>
                  <a class='remove-img'><i class='fa fa-remove' /></a>
                  <a class='thumbnail'>
                  <img src='" + response.data.resource.middle.url + "' width='100' height='100' asset-id='" + response.data.id + "'/ > 
                  </a>
                  </div> "
          
          $('.row').append($img)
        else
          $('.alert.alert-danger').removeClass('sr-only').text(response.data)
        
        return    

  checkCategory : (e) ->
    $this = $(e.currentTarget)

    if $this.hasClass('active')
      $this.removeClass('active')
    else
      $this.addClass('active')

  removeImg : (e) ->
    $this = $(e.currentTarget)
    $this.closest('.img-panel').remove()      
    

  handCategory : (e) ->    
    $(e.currentTarget).css('cursor', 'pointer')


  createGoods : () ->
    $alert = $('.alert.alert-danger')    
    category_ids = []
    photo_asset_ids = []

    $('.categories span.label-category.active').each ->
      category_ids.push $(this).attr('category-id')

    category_ids = category_ids.join(',')      

    $('.row img').each ->
      photo_asset_ids.push $(this).attr('asset-id')

    photo_asset_ids = photo_asset_ids.join(',')
    
    name = $('input[name=name]').val()
    price = $('input[name=price]').val()
    description = good_description.html()    

    if category_ids == ''            
      $alert.empty().text('商品分类不能为空')      
      $alert.removeClass('sr-only')  
      return

    else if price == ''
      this.alertMsg('价格不能为空')
      return
    else if isNaN(price)          
      this.alertMsg('价格必须为数字')
      return
    else if parseInt(price) <= 0      
      this.alertMsg('价格必须大于等于0')
      return
    else if name == ''
      this.alertMsg('规格不能为空')
      return          

    else
      $.post '/goods', {category_ids: category_ids, price: price, photo_asset_ids: photo_asset_ids, name: name, description: description}, (res) ->
        if res.success
          $("#goodsModal").modal()
        else
          $alert.empty().text(res.error)
          $alert.removeClass('sr-only')

  updateGoods : () ->
    $alert = $('.alert.alert-danger')    
    category_ids = []
    photo_asset_ids = []

    $('.categories span.label-category.active').each ->
      category_ids.push $(this).attr('category-id')

    category_ids = category_ids.join(',')

    $('.row img').each ->
      photo_asset_ids.push $(this).attr('asset-id')

    photo_asset_ids = photo_asset_ids.join(',')

    name = $('input[name=name]').val()
    price = $('input[name=price]').val()
    good_id = $('input[name=good_id]').val()
    description = good_description.html()    

    if category_ids == ''            
      $alert.empty().text('商品分类不能为空')      
      $alert.removeClass('sr-only')  
      return

    else if price == ''
      this.alertMsg('价格不能为空')
      return
    else if isNaN(price)          
      this.alertMsg('价格必须为数字')
      return
    else if parseInt(price) <= 0      
      this.alertMsg('价格必须大于等于0')
      return
    else if name == ''
      this.alertMsg('规格不能为空')
      return          

    else
      $.ajax
        type: 'PUT'
        url: '/goods/' + good_id
        data: {category_ids: category_ids, price: price, photo_asset_ids: photo_asset_ids, name: name, description: description}
        success: (res) ->
          if res.success
            window.location.href = "/goods"
          else
            $alert.empty().text(res.error)
            $alert.removeClass('sr-only')            

          return                  