window.PosterView = Backbone.View.extend
  el: 'body'


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
                  <a class='thumbnail'>
                  <img src='" + response.data.resource.middle.url + "' / > 
                  </a>
                  </div> "
          
          $("input[name=asset_id]").val(response.data.id)

          $('.row').empty().append($img)
        else
          $('.alert.alert-danger').removeClass('sr-only').text(response.data)
        
        return 

  
  checkGood: () ->

    $.post '/posters/good_info', {good_id: $("input[name=good_id]").val()}, (res) ->
      if res.success
        alert "商品名称: #{res.good_name}"
      else
        alert '未找到该商品!'

               