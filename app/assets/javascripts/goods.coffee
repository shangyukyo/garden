window.GoodView = Backbone.View.extend
  el: '.goods'
  
  events: {
    'click .categories span.label-category': 'checkCategory'
    'mouseover .categories span.label-category' : 'handCategory'
    'click a.createGoodsBtn' : 'createGoods'
    'click a.updateGoodsBtn' : 'updateGoods' 
  }

  initialize: () ->
    #...

  checkCategory : (e) ->
    $this = $(e.currentTarget)

    if $this.hasClass('active')
      $this.removeClass('active')
    else
      $this.addClass('active')
    

  handCategory : (e) ->    
    $(e.currentTarget).css('cursor', 'pointer')


  createGoods : () ->
    $alert = $('.alert.alert-danger')    
    category_ids = []

    $('.categories span.label-category.active').each ->
      category_ids.push $(this).attr('category-id')

    category_ids = category_ids.join(',')
    name = $('input[name=name]').val()
    description = good_description.html()    

    if category_ids == ''            
      $alert.empty().text('商品分类不能为空')      
      $alert.removeClass('sr-only')      

      return
    else
      $.post '/goods', {category_ids: category_ids, name: name, description: description}, (res) ->
        if res.success
          window.location.href = "/goods/" + res.data.id + "/new_good_spec"
        else
          $alert.empty().text(res.error)
          $alert.removeClass('sr-only')

  updateGoods : () ->
    $alert = $('.alert.alert-danger')    
    category_ids = []

    $('.categories span.label-category.active').each ->
      category_ids.push $(this).attr('category-id')

    category_ids = category_ids.join(',')
    name = $('input[name=name]').val()
    good_id = $('input[name=good_id]').val()
    description = good_description.html()    

    if category_ids == ''            
      $alert.empty().text('商品分类不能为空')      
      $alert.removeClass('sr-only')      

      return
    else
      $.ajax
        type: 'PUT'
        url: '/goods/' + good_id
        data: {category_ids: category_ids, name: name, description: description}
        success: (res) ->
          if res.success
            window.location.href = "/goods"
          else
            $alert.empty().text(res.error)
            $alert.removeClass('sr-only')            

          return                  