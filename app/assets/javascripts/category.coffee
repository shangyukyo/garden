window.CategoryView = Backbone.View.extend
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
