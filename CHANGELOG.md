Workarea Stripe 1.1.2 (2020-02-05)
--------------------------------------------------------------------------------

*   Fix bogus gateway response data

    Update date returned by store operation to be the current year plus 1
    Jason Hummel



Workarea Stripe 1.1.1 (2020-01-21)
--------------------------------------------------------------------------------

*   Fix Tests for 2020

    Update all tests so that they no longer depend on the year 2020 as an
    expiration year. Instead, use the  method provided by Workarea.

    STRIPE-2
    Tom Scott



Workarea Stripe 1.1.0 (2019-11-26)
--------------------------------------------------------------------------------

*   Remove decorator for test that was removed in base

    Ben Crouse

*   Update credit card issuer validation to allow strip tokens

    Jeff Yucis

*   Update README

    Matt Duffy



Workarea Stripe 1.0.0 (2019-08-21)
--------------------------------------------------------------------------------

*   Open Source!



Workarea Stripe 1.0.0.beta.3 (2018-09-28)
--------------------------------------------------------------------------------

*   Bump version for beta.3 release

    Jake Beresford

*   Fix stripe elements UI issues

    * Ensure width of stripe form is always 100% of it's container, sometimes stripe card elements had a width of 1px when they were mounted to the DOM
    * Adds a new view partial for stripe card form in user account due to missing @step

    STRIPE-4
    Jake Beresford

*   * Adds a new view partial for stripe card form in user account

    STRIPE-4 (reverted from commit 7d2515436f2e4c253674640705f298060350cc9b)
    Jake Beresford

*   * Adds a new view partial for stripe card form in user account

    STRIPE-4
    Jake Beresford



Workarea Stripe 1.0.0.beta.2 (2018-09-27)
--------------------------------------------------------------------------------

*   Add compatiblity for for V 3.x

    FLOW-3
    Jeff Yucis



Workarea Stripe 1.0.0.beta.1 (2018-09-27)
--------------------------------------------------------------------------------

*   Add compatiblity for for V 3.x

    FLOW-3
    Jeff Yucis



Workarea Stripe 1.0.0.beta.1 (2018-09-26)
--------------------------------------------------------------------------------

*   Stripe Payment Processor Integration

    Implements the stripe payment processor with the elements.js
    for a hosted payment form.

    STRIPE-1
    Jeff Yucis



