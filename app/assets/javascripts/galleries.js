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
    var galleryId = $(this).data('gallery');
    var triggerTimeout = function(galleryId){
      $.ajax({
        url: '/admin/galleries/' + galleryId + '/is_updated',
        type: 'get',
        dataType: 'script',
        complete: function(response){
          var responseData = JSON.parse(response.responseText);
          console.log(responseData);
          if (responseData.is_updated){
            $('#spinner-' + galleryId).hide();
            $('#success-' + galleryId).show();
            $('#image-count-' + galleryId).html(responseData.number_of_images);
            $('#updated-at-' + galleryId).html(responseData.current_timestamp);
            $('#' + galleryId + ' td').effect('highlight');
          }
          else{
            setTimeout(function(){triggerTimeout(galleryId);}, 500);
          }
        }
      });
    };
    triggerTimeout(galleryId);
  });
});

