$(document).ready(function(){
  $('#portfolio-images').sortable({
    axis: 'y',
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        url: '/gallery/' + $(this).data('tag') + '/sort',
        type: 'patch',
        data: $('#portfolio-images').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#portfolio-images').effect('highlight');
        }
      });
    }
  });
});

/*
$(document).ready(function(){
  $('#portfolio-images').sortable({
    axis: 'y',
    dropOnEmpty: false,
    handle: '.handle',
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        url: '/gallery/' + $(this).data('tag') + 'sort',
        type: 'patch',
        data: $('#portfolio-images').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#portfolio-images').effect('highlight');
        }
      });
    }
  });
});
*/
