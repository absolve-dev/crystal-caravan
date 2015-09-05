// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$('checkOut_btnNext').ready(function() {
  $('.checkOut_btnNext').click(function(){
    $('#checkout_nav_tabs > .active').next('li').find('a').trigger('click');
  });
  
  $('.checkOut_btnPrevious').click(function(){
    $('#checkout_nav_tabs > .active').prev('li').find('a').trigger('click');
  });
});