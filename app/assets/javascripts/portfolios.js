$(document).ready(function(){
  $('#portfolio-images').sortable({
    axis: 'y',
    cursor: 'crosshair',
    items: 'tr',
    opacity: 0.4,
    scroll: true,
    update: function(){
      var imagesTable = $('#portfolio-images');
      var data = {};
      imagesTable.find('tr').each(function(index){
        var id = $(this).attr('id');
        data[id] = index;
      });
      $.ajax({
        url: '/gallery/' + imagesTable.data('portfolio') + '/sort',
        type: 'patch',
        data: {positions: data},
        dataType: 'script',
        complete: function(request){
          $('#portfolio-images').effect('highlight');
        }
      });
    }
  });
});
