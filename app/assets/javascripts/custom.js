$(document).ready(function() {
  hideAlerts();

  function hideAlerts(){
    setTimeout(function() {
      $('.alerts-bar').slideUp('slow')
    }, 3000);
  }



  // instantiate the bloodhound suggestion engine
  var numbers = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
       url: '/search?query=%QUERY',
       wildcard: '%QUERY'
     }
  });

  // initialize the bloodhound suggestion engine
  numbers.initialize();

  // instantiate the typeahead UI
  $('.typeahead').typeahead(null, {
    source: numbers.ttAdapter()
  });

});