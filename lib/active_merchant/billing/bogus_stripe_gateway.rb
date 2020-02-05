module ActiveMerchant
  module Billing
    class BogusStripeGateway < BogusGateway
      def initialize(options = {})
        # noop
      end


      def authorize(money, paysource, options = {})
        if paysource.respond_to?(:emv?) && paysource.emv?
          authorize_emv(money, paysource, options)
        else
          authorize_swipe(money, paysource, options)
        end
      end

      def store(paysource, options = {})
        case normalize(paysource)
        when /1$/, /^tok/, ""
          Response.new(true, SUCCESS_MESSAGE, { "id" => "cus_5678", "sources" => { "data" => [{ "id" => 'card_1111', "last4" => '1111', "exp_month" => "1", "exp_year" => (Time.current.year + 1).to_s, "brand" => "Test Card" }] } }, test: true)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { billingid: nil, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end
    end
  end
end
