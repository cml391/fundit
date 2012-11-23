# Stripe integration for the donationform. Instead of allowing sensitive credit
# card details hit the MagiCart server, we have the client submit payment
# information directly to Stripe via an AJAX call. Stripe gives us back a
# single-use token which we send to the server.

Donations =
    onLoad: ->
        # Register Donations.onSubmit as the submit handler for the payment form
        $("#stripe-payment-form").submit Donations.onSubmit

    onSubmit: (event)->
        # disable the submit button to prevent repeated clicks
        $('.submit-button').attr "disabled", "disabled"
        $('.alert-error').slideUp()

        # submit an AJAX request -- send payment details to Stripe and get a
        # Stripe single-use token in exchange.
        Stripe.createToken
            number:    $('.card-number').val(),
            cvc:       $('.card-cvc').val(),
            exp_month: $('.card-expiry-month').val(),
            exp_year:  $('.card-expiry-year').val()
            Donations.stripeResponseHandler

        # prevent the form from submitting with the default action
        return false;

    stripeResponseHandler: (status, response) ->
        if response.error
            # show the errors on the form
            $('.alert-error').slideUp ->
                $(".alert-error").text response.error.message
                $('.alert-error').slideDown()

            $(".submit-button").removeAttr "disabled"
        else
            # no error, stick a hidden field in the form to send the token
            # with the form.
            form = $("#stripe-payment-form");
            # token contains id, last4, and card type
            token = response['id'];
            # insert the token into the form so it gets submitted to the server
            form.append("<input type='hidden' name='donation[stripe_token]' value='#{token}'/>");
            # and submit
            form.get(0).submit();



$(document).ready Donations.onLoad