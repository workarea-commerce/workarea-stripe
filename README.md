Workarea Stripe
================================================================================

Stripe plugin for the Workarea platform.

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-stripe'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Configuration
--------------------------------------------------------------------------------

To configure the stripe plugin you will need both a public and secret key from stripe. Setting up a stripe sandbox for development is very easy, just create an account at <https://dashboard.stripe.com/register>. Once you have an account visit <https://dashboard.stripe.com/account/apikeys> to access your keys.

Add the following configuration to your app secrets

```ruby
  stripe:
    login: secret_key_from_stripe
    public_key: public_key_from_stripe
```

Setting up your checkout payment view
--------------------------------------------------------------------------------

If you have not yet customized your checkout/payment view your application will
automatically use the one provided by this plugin. If you need to customize this
view please override the one from the workarea-stripe plugin as it includes the
necessary changes to markup in order for stripe to work.

If you have already overridden checkout/payment from workarea core you will need
to make a couple of additional changes to the view file to use stripe.

1. Add data-stripe-payment-form to the #checkout_form on the payment view
2. Remove the new card inputs, replacing them with the stripe_form partial.

example:

```ruby
= render 'workarea/storefront/checkouts/stripe_form', step: @step
```

See the checkouts/payment.html.haml view in this plugin for reference.

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Stripe is released under the [Business Software License](LICENSE)
