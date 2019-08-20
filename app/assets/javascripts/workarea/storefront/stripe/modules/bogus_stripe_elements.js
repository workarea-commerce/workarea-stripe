WORKAREA.registerModule('bogusStripeElements', (function () {

    'use strict';

    var createStripeTokenInput = function() {
            return $('<input>').attr({
                'type': 'hidden',
                'name': 'stripeToken',
                'value': WORKAREA.config.stripe.bogusToken.id
            });
        },

        paymentMethod = function($form) {
            return $('input[name="payment"]:checked', $form).val();
        },

        formNeedsTokenization = function($form) {
            if ($form.attr('action') === '/checkout/place_order') {
                return paymentMethod($form) === 'stripe';
            } else {
                return true;
            }
        },

        setupPaymentForm = function (index, paymentForm) {
            var $form = $(paymentForm),
                hiddenInput = createStripeTokenInput();

            if (formNeedsTokenization($form)) {
                $form.append(hiddenInput);
            }
        },

        disable = function() {
            $('.checkout-payment__primary-method').css('display', 'none');
            $('.checkout-payment__primary-method--stripe').css('display', 'block');
        },

        /**
         * @method
         * @name init
         * @memberof WORKAREA.bogusStripeElements
         */
        init = function ($scope) {
            var $stripePayment = $('[data-stripe-card-input]', $scope),
                $paymentForm = $stripePayment.closest('form');

            $paymentForm.each(setupPaymentForm);
        };

    return {
        init: init,
        disable: disable
    };
}()));
