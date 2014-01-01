$(document).ready(function(){
  $('#gallery-images').sortable({
    axis: 'y',
    cursor: 'crosshair',
    items: 'tr',
    opacity: 0.4,
    scroll: true,
    update: function(){
      var imagesTable = $('#gallery-images');
      var data = {};
      imagesTable.find('tr').each(function(index){
        var id = $(this).attr('id');
        data[id] = index;
      });
      $.ajax({
        url: '/admin/galleries/' + imagesTable.data('gallery') + '/reorder',
        type: 'patch',
        data: {positions: data},
        dataType: 'script',
        complete: function(response){
          $('#gallery-images').effect('highlight');
        }
      });
    }
  });
});

$(document).ready(function(){
  $('.loading-spinner').each(function(){
    var cacheTag = $(this).data('cache');
    var triggerTimeout = function(cacheId){
      $.ajax({
        url: '/admin/galleries/' + cacheTag + '/is_updated',
        type: 'get',
        dataType: 'script',
        complete: function(response){
          if (response.responseText == 'true'){
            $('#spinner-' + cacheTag).hide();
            $('#success-' + cacheTag).show();
          }
          else{
            setTimeout(function(){triggerTimeout(cacheTag);}, 2000);
          }
        }
      });
    };
    triggerTimeout(cacheTag);
  });
});

