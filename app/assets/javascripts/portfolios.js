$(document).ready(function(){
  $('#sortable-table').sortable({
    axis: 'y',
    cursor: 'crosshair',
    items: 'tr',
    opacity: 0.4,
    scroll: true,
    update: function(){
      var imagesTable = $('#sortable-table');
      var data = {};
      imagesTable.find('tr').each(function(index){
        var id = $(this).attr('id');
        data[id] = index;
      });
      $.ajax({
        url: imagesTable.data('updateUrl'),
        type: 'patch',
        data: {positions: data},
        dataType: 'script',
        complete: function(response){
          $('#sortable-table').effect('highlight');
          if (!(imagesTable.data('callback').toString() == 'undefined')){
            eval(imagesTable.data('callback').toString());
          }
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

