WORKAREA.registerModule('stripeElements', (function () {

    'use strict';

    if (!WORKAREA.config.stripe.publicKey) { return; }

    var stripe = Stripe(WORKAREA.config.stripe.publicKey),
        elements = stripe.elements(),
        card,

        createStripeTokenInput = function(token) {
            return $('<input>').attr({
                'type': 'hidden',
                'name': 'stripeToken',
                'value': token.id
            });
        },

        stripeTokenHandler = function($form, token) {
            var hiddenInput = createStripeTokenInput(token);

            $form
            .append(hiddenInput)
            .unbind('submit')
            .submit();
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

        tokenizeFormOnSubmit = function ($form, event) {
            if (formNeedsTokenization($form)) {
                event.preventDefault();

                stripe.createToken(card).then(function (result) {
                    if (result.error) {
                        var errorElement = $('#card_errors');
                        errorElement.textContent = result.error.message;
                    } else {
                        stripeTokenHandler($form, result.token);
                    }
                });
            }
        },

        setupPaymentForm = function ($paymentForm) {
            $paymentForm.on('submit', _.partial(tokenizeFormOnSubmit, $paymentForm));
        },

        displayErrorsOnChange = function(event) {
            var displayError = $('#card_errors');

            if (event.error) {
                displayError.textContent = event.error.message;
            } else {
                displayError.textContent = '';
            }
        },

        setIframeId = function($container) {
            $('iframe', $container).attr('id', 'stripe-payment-frame');
        },

        // Inline styles are necessary here to override an inline style sometimes
        // added by stripe elements. It seems stripe attempts to hide the card
        // form by setting width: 1px !important; on the iframe, causing the form
        // not to render in some checkouts. The iframe should always fill it's container
        ensureIframeWidth = function ($container) {
            $('iframe', $container).css('width', '100%');
        },

        setupCardInput = function($cardInput) {
            var cardInputID = $cardInput.attr('id');

            card = elements.create('card', { style: WORKAREA.config.stripe.cardStyles });
            card.mount('#'+cardInputID);
            card.addEventListener('change', displayErrorsOnChange);
            setIframeId($cardInput);
            ensureIframeWidth($cardInput);
        },

        setupStripe = function (index, cardInput) {
            var $cardInput = $(cardInput),
                $paymentForm = $cardInput.closest('form');

            setupCardInput($cardInput);
            setupPaymentForm($paymentForm);
        },

        /**
         * @method
         * @name init
         * @memberof WORKAREA.stripeElements
         */
        init = function ($scope) {
            if (!WORKAREA.config.stripe.publicKey) { return; }

            $('[data-stripe-card-input]', $scope).each(setupStripe);
        };

    return {
        init: init
    };
}()));
