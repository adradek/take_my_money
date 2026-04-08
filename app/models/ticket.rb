class Ticket < ApplicationRecord
  belongs_to :performance
  belongs_to :user, optional: true

  has_one :event, through: :performance

  monetize :price_cents

  enum access: { general: 0 }
  enum status: { unsold: 0, waiting: 1 }

  def place_in_cart_for(user)
    update(status: :waiting, user: user)
  end
end
