class PaymentLineItem < ApplicationRecord
  belongs_to :buyable, polymorphic: true
  belongs_to :payment

  monetize :price_cents
end
