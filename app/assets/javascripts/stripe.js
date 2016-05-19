$(document).ready(function() {

  $("#payment-form").submit(function(event) {
      $('#submitBtn').attr('disabled', 'disabled');
      return false;
  });

  var error = false;

  var ccNum = $('.card-number').val(),
      cvcNum = $('.card-cvc').val(),
      expMonth = $('.card-expiry-month').val(),
      expYear = $('.card-expiry-year').val();

  if (!Stripe.card.validateCardNumber(ccNum)) {
    error = true;
    reportError('The credit card number appears to be invalid.');
  }

  if (!Stripe.card.validateCVC(cvcNum)) {
    error = true;
    reportError('The CVC number appears to be invalid.');
  }

  if (!Stripe.card.validateExpiry(expMonth, expYear)) {
    error = true;
    reportError('The expiration date appears to be invalid.');
  }

  if (!error) {
    Stripe.card.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
    }, stripeResponseHandler);
   }

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
