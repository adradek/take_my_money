class Performance < ApplicationRecord
  has_many :tickets, dependent: :destroy

  belongs_to :event

  def unsold_tickets(count)
    tickets.unsold.limit(count)
  end
end
