require "rails_helper"

RSpec.describe "tickets purchasing", :vcr do
  let(:buyer) { create(:user) }
  let(:performance) { create(:performance, event: create(:event)) }

  let(:tickets) do
    2.times.map { create(:ticket, performance: performance, status: "unsold", price: Money.new(1500)) }
  end

  before do
    sign_in_with(buyer.email, buyer.password)
    tickets.each { |t| t.place_in_cart_for(buyer) }
  end

  # rubocop:disable RSpec/ExampleLength, RSpec/PendingWithoutReason
  xit "purchases tickets with credit card", :aggregate_failures do
    visit shopping_cart_path
    fill_in :credit_card_number, with: "4242 4242 4242 4242"
    fill_in :expiration_month, with: "12"
    fill_in :expiration_year, with: Time.zone.now.year + 1
    fill_in :cvc, with: "123"
    click_on "purchase"

    expect(page).to have_selector(".purchased_ticket", count: 2)
    expect(page).to have_selector("#purchased_ticket_#{tickets[0].id}")
    expect(page).to have_selector("#purchased_ticket_#{tickets[1].id}")
  end
  # rubocop:enable RSpec/ExampleLength, RSpec/PendingWithoutReason
end
