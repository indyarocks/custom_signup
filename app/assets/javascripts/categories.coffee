# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#category_keyword').autocomplete
    minLength: 2
    source: $('#category_keyword').data('autocomplete-source')



