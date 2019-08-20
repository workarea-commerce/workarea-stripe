require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::Stripe::Engine.root
  Workarea::Teaspoon.apply(config)
end
