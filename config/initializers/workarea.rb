Workarea::Stripe.auto_initialize_gateway

Workarea.configure do |config|
  config.stripe = ActiveSupport::Configurable::Configuration.new

  if Workarea::Stripe.credentials.present?
    config.stripe.public_key = Workarea::Stripe.credentials[:public_key]
  end
end
