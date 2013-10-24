# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.date_time').datepicker
    dateFormat: 'yy-mm-dd'
  $('.date_time1').datepicker
    dateFormat: 'yy-mm-dd'
  $('.end_time').timepicker()