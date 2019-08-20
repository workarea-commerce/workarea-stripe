require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/stripe/engine'
require 'workarea/stripe/version'

require 'active_merchant/billing/bogus_stripe_gateway'

module Workarea
  module Stripe
    # Credentials for StripeGateway from Rails secrets.
    #
    # @return [Hash]
    def self.credentials
      return {} unless Rails.application.secrets.stripe.present?
      Rails.application.secrets.stripe.symbolize_keys
    end

    # Conditionally use the real gateway when secrets are present.
    # Otherwise, use the bogus gateway.
    #
    # @return [ActiveMerchant::Billing::Gateway]
    def self.gateway
      Workarea.config.gateways.credit_card
    end

    def self.gateway=(gateway)
      Workarea.config.gateways.credit_card = gateway
    end

    def self.auto_initialize_gateway
      if credentials.present?
        if ENV['HTTP_PROXY'].present?
          uri = URI.parse(ENV['HTTP_PROXY'])
          ActiveMerchant::Billing::StripeGateway.proxy_address = uri.host
          ActiveMerchant::Billing::StripeGateway.proxy_port = uri.port
        end

        self.gateway = ActiveMerchant::Billing::StripeGateway.new credentials
      else
        self.gateway = ActiveMerchant::Billing::BogusStripeGateway.new
      end
    end
  end
end
