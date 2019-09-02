$(document).ready(function () {
  $('.player-dropdown').on('change', function () {
    var winner = $('#winner-dropdown');
    var loser = $('#loser-dropdown');

    var result = !(winner.val() && loser.val() && winner.val() != loser.val())
    $('#process-roll').attr('disabled', result);
  });

  $('.rng-input').on('change', function() {
    var result = !(Number.isInteger(parseInt($('#players').val())) && Number.isInteger(parseInt($('#rolls').val())));
    $('#generate').attr('disabled', result);
  });

  $('.confirm').on('click', function () {
    return confirm('Are you sure? This will overwrite any progress you have.');
  });
});


