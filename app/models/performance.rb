class Performance < ApplicationRecord
  has_many :tickets, dependent: :destroy

  belongs_to :event
end
