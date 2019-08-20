Workarea Stripe
================================================================================

Stripe plugin for the Workarea platform.

Configuration
--------------------------------------------------------------------------------

To configure the stripe plugin you will need both a public and secret key from stripe.
Setting up a stripe sandbox for development is very easy, just create an account
at <https://dashboard.stripe.com/register>.
Once you have an account visit <https://dashboard.stripe.com/account/apikeys> to
access your keys.

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

Getting Started
--------------------------------------------------------------------------------

This gem contains a rails engine that must be mounted onto a host Rails application.

To access Workarea gems and source code, you must be an employee of WebLinc or a licensed retailer or partner.

Workarea gems are hosted privately at https://gems.weblinc.com/.
You must have individual or team credentials to install gems from this server. Add your gems server credentials to Bundler:

    bundle config gems.weblinc.com my_username:my_password

Or set the appropriate environment variable in a shell startup file:

    export BUNDLE_GEMS__WEBLINC__COM='my_username:my_password'

Then add the gem to your application's Gemfile specifying the source:

    # ...
    gem 'workarea-stripe', source: 'https://gems.weblinc.com'
    # ...

Or use a source block:

    # ...
    source 'https://gems.weblinc.com' do
      gem 'workarea-stripe'
    end
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Workarea Platform Documentation
--------------------------------------------------------------------------------

See [http://developer.weblinc.com](http://developer.weblinc.com) for Workarea platform documentation.

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright WebLinc 2018. All rights reserved.

For licensing, contact sales@workarea.com.
