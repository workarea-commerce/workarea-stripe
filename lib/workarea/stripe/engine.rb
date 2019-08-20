module Workarea
  module Stripe
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Stripe
    end
  end
end
