window.GoodSpecView = Backbone.View.extend
  el: '.good-spec'

  good_id: ''
  
  events: {
    'click a.createGoodspecBtn' : 'createGoodSpec'
    'click a.updateGoodspecBtn' : 'updateGoodSpec'
    'click a.remove-img' : 'removeImg'
  }

  initialize: (opts) ->

    if opts != undefined
      this.good_id = opts['good_id']

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

  removeImg : (e) ->
    $this = $(e.currentTarget)
    $this.closest('.img-panel').remove()
           

  createGoodSpec : () ->
    self = this
    photo_asset_ids = []

    $('.row img').each ->
      photo_asset_ids.push $(this).attr('asset-id')

    photo_asset_ids = photo_asset_ids.join(',')

    name = $('input[name=name]').val()
    price = $('input[name=price]').val()
    description = goodspec_description.html()
    
    if price == ''
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

    $.post "/goods/" + this.good_id + "/create_good_spec", {name: name, photo_asset_ids: photo_asset_ids, price: price, description: description}, (res) ->

      if res.success
        $("#goodspecModal").modal()
        
      else
        self.alertMsg(res.data)

  updateGoodSpec : () ->
    self = this    
    photo_asset_ids = []

    $('.row img').each ->
      photo_asset_ids.push $(this).attr('asset-id')

    photo_asset_ids = photo_asset_ids.join(',')

    good_spec_id = $('input[name=good_spec_id]').val()
    name = $('input[name=name]').val()
    price = $('input[name=price]').val()
    description = goodspec_description.html()
    
    if price == ''
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

    $.post "/goods/update_good_spec", {good_spec_id: good_spec_id, name: name, photo_asset_ids: photo_asset_ids, price: price, description: description}, (res) ->

      if res.success
        window.location.href = "/goods"
        
      else
        self.alertMsg(res.data)    



  alertMsg : (msg) ->
    $('.alert.alert-danger').removeClass('sr-only').text(msg)