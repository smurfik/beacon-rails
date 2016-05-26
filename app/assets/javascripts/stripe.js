$(document).ready(function() {

  $("#payment-form").submit(function(event) {
    event.preventDefault();
    $('#submitBtn').attr('disabled', 'disabled');

    Stripe.card.createToken({
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-year').val()
    }, stripeResponseHandler);
  });

  function stripeResponseHandler(status, response) {
    if (response.error) {
      reportError(response.error.message);
    } else {
      var f = $("#payment-form");
      var token = response.id;
      f.append('<input type="hidden" name="stripeToken" value="' + token + '" />');
      f.get(0).submit();
    }
  }

  function reportError(msg) {
    $('#payment-errors').text(msg).addClass('error');
    $('#submitBtn').prop('disabled', false);
    return false;
  }

});
