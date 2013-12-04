$(document).ready(function() {
  var backgroundImage = $('img.background_image');
  backgroundImage.hide();
  // fade in immediately when the image is loaded, if it isn't loaded after 500 ms
  window.setTimeout(function() {
    backgroundImage.load(function() {
      backgroundImage.fadeIn(3000);
    });
  }, 500);
  // wait for 500 ms before fading in the image if it's loaded before the above timeout triggers
  backgroundImage.load(function() {
    window.setTimeout(function() {
      backgroundImage.fadeIn(3000);
    }, 500);
  });
});
