(function() {
  window.GoodView = Backbone.View.extend({
    el: '.goods',
    events: {
      'click .categories span.label-category': 'checkCategory',
      'mouseover .categories span.label-category': 'handCategory',
      'click a.createGoodsBtn': 'createGoods'
    },
    initialize: function() {},
    checkCategory: function(e) {
      var $this;
      $this = $(e.currentTarget);
      if ($this.hasClass('active')) {
        return $this.removeClass('active');
      } else {
        return $this.addClass('active');
      }
    },
    handCategory: function(e) {
      return $(e.currentTarget).css('cursor', 'pointer');
    },
    createGoods: function() {
      var $alert, category_ids, description, name;
      $alert = $('.alert.alert-danger');
      category_ids = [];
      $('.categories span.label-category.active').each(function() {
        return category_ids.push($(this).attr('category-id'));
      });
      category_ids = category_ids.join(',');
      name = $('input[name=name]').val();
      description = good_description.html();
      if (category_ids === '') {
        $alert.empty().text('商品分类不能为空');
        $alert.removeClass('sr-only');
      } else {
        return $.post('/goods', {
          category_ids: category_ids,
          name: name,
          description: description
        }, function(res) {
          if (res.success) {
            return window.location.href = "/goods/" + res.data.id + "/new_good_spec";
          } else {
            $alert.empty().text(res.error);
            return $alert.removeClass('sr-only');
          }
        });
      }
    }
  });

}).call(this);
