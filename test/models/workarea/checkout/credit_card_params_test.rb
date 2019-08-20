require 'test_helper'

module Workarea
  class Checkout::CreditCardParamsTest < TestCase
    def test_strip
      cc_params = Workarea::Checkout::CreditCardParams.new("stripeToken" => '123')
      assert(cc_params.stripe?)
    end
  end
end
