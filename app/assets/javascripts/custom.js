$(document).foundation();

$(function() {
  $('a.radius').click(function(e) {
    $('#visualize h2').html($(this).data('heading'));
    $('#user_graph').html('Loading graph please wait...');
    e.preventDefault();
    $.getJSON($(this).attr('href'), function(data) {
      $('#visualize').bind('opened', function() {
        $('#user_graph').html('');
        Morris.Line({
          element: 'user_graph',
          xkey: 'reading_start_time',
          ykeys: ['bpm'],
          labels: ['BPM'],
          data: data.sessions
        });
      });
    });
  });
});
