class Ticket < ApplicationRecord
  has_one :event, through: :performance

  belongs_to :performance
  belongs_to :user, optional: true

  monetize :price_cents

  enum access: { general: 0 }
  enum status: { unsold: 0, waiting: 1 }
end
