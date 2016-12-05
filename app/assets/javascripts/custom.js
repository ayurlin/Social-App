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
  $('.typeahead').typeahead({ minLength: 2, highlight: true }, {
    display: function(item){ return item.name+' '+item.last_name},
    limit: 10,
    source: numbers.ttAdapter(),
    templates: {
            empty: 'not found', //optional
            suggestion: function(item){ return '<a href="/users/' + item.id + '=' + item.name + item.last_name + '">' + item.name + ' ' + item.last_name + '<img class="thumb-img" src="'+item.avatar.url+'" />' + '</a>' }
        }
  })





});