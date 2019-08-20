module Workarea
  Plugin.append_partials(
    'storefront.document_head',
    'workarea/storefront/stripe/stripe_js'
  )

  Plugin.append_javascripts(
    'storefront.config',
    'workarea/storefront/stripe/config'
  )

  Plugin.append_partials(
    'storefront.payment_method',
    'workarea/storefront/checkouts/stripe_form'
  )

  Plugin.append_javascripts(
    'storefront.modules',
    'workarea/storefront/stripe/modules/stripe_elements'
  )

  if Rails.env.test?
    Plugin.append_javascripts(
      'storefront.modules',
      'workarea/storefront/stripe/modules/bogus_stripe_elements'
    )
  else
    Plugin.append_stylesheets(
      'storefront.components',
      'workarea/stripe/components/checkout_payment_stripe'
    )
  end
end
