require 'test_helper'

module Workarea
  module Storefront
    class StripePaymentSystemTest < Workarea::SystemTest
      include Storefront::SystemTest

      setup :setup_checkout_specs
      setup :start_guest_checkout

      def fill_in_stripe_credit_card
        page.evaluate_script('WORKAREA.bogusStripeElements.disable()')

        page.driver.browser.switch_to.frame "stripe-payment-frame"

        find('input[name="cardnumber"]').set('4111111111111111')
        find('input[name="exp-date"]').set('12/21')
        find('input[name="cvc"]').set('999')
        find('input[name="postal"]').set('19143')

        page.driver.browser.switch_to.default_content
      end

      def test_successfully_checking_out
        assert_current_path(storefront.checkout_addresses_path)
        fill_in_email
        fill_in_shipping_address
        uncheck 'same_as_shipping'
        fill_in_billing_address
        click_button t('workarea.storefront.checkouts.continue_to_shipping')

        assert_current_path(storefront.checkout_shipping_path)
        assert(page.has_content?('Success'))

        click_button t('workarea.storefront.checkouts.shipping_instructions_prompt')
        instruction = 'Doorbeel broken, please knock'
        fill_in :shipping_instructions, with: instruction

        click_button t('workarea.storefront.checkouts.continue_to_payment')

        assert_current_path(storefront.checkout_payment_path)

        assert(page.has_content?('Success'))

        assert(page.has_content?('22 S. 3rd St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19106'))
        assert(page.has_content?('Ground'))

        assert(page.has_content?('Integration Product'))
        assert(page.has_content?('SKU'))

        assert(page.has_content?('$5.00')) # Subtotal
        assert(page.has_content?('$7.00')) # Shipping
        assert(page.has_content?('$0.84')) # Tax
        assert(page.has_content?('$12.84')) # Total

        assert(page.has_content?(instruction))

        fill_in_stripe_credit_card
        click_button t('workarea.storefront.checkouts.place_order')
        wait_for_xhr

        assert_current_path(storefront.checkout_confirmation_path)

        assert(page.has_content?('Success'))
        assert(page.has_content?(t('workarea.storefront.flash_messages.order_placed')))
        assert(page.has_content?(Order.first.id))

        assert(page.has_content?('22 S. 3rd St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19106'))
        assert(page.has_content?('Ground'))

        assert(page.has_content?('1019 S. 47th St.'))
        assert(page.has_content?('Philadelphia'))
        assert(page.has_content?('PA'))
        assert(page.has_content?('19143'))

        assert(page.has_content?('Visa'))
        assert(page.has_content?('1111'))

        assert(page.has_content?(instruction))

        assert(page.has_content?('Integration Product'))
        assert(page.has_content?('SKU'))

        assert(page.has_content?('$5.00')) # Subtotal
        assert(page.has_content?('$7.00')) # Shipping
        assert(page.has_content?('$0.84')) # Tax
        assert(page.has_content?('$12.84')) # Total
      end
    end
  end
end
