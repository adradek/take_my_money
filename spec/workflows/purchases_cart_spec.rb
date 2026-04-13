require "rails_helper"

RSpec.describe PurchasesCart do
  # rubocop:disable RSpec/PendingWithoutReason
  xdescribe "successful credit card payment", :vcr do
    let(:reference) { Payment.generate_reference }
    let(:tickets) do
      (1..2).map { |id| instance_spy(Ticket, status: "waiting", price: Money.new(1500), id: id) } \
        << instance_spy(Ticket, status: "unsold", id: 3)
    end

    let(:user) { instance_double(User, id: 5, tickets_in_cart: tickets[0..1]) }
    let(:token) do
      StripeToken.new(
        credit_card_number: "4242424242424242",
        expiration_month: "12",
        expiration_year: Time.zone.now.year + 1,
        cvc: "123"
      )
    end
    let(:workflow) { described_class.new(user: user, purchase_amount_cents: 3000, stripe_token: token) }
    let(:attributes) do
      { user_id: user.id, price_cents: 3000, reference: a_truthy_value, payment_method: "stripe", status: "created" }
    end
    let(:payment) { instance_double(Payment, succeeded?: true, price: Money.new(3000), reference: reference) }

    before do
      allow(Payment).to receive(:create!).with(attributes).and_return(payment)
      allow(payment).to receive(:update!).with(status: "succeeded", response_id: a_string_starting_with("ch_"), full_response: a_truthy_value)
      allow(payment).to receive(:create_line_items)
      workflow.run
    end

    it "updates the ticket status", :aggregate_failures do
      expect(payment).to have_received(:create_line_items).with(tickets[0..1])
      expect(tickets).to all(have_received(:purchased!))
      expect(workflow.payment_attributes).to match(attributes)
      expect(workflow.success).to be_truthy
    end
  end
  # rubocop:enable RSpec/PendingWithoutReason
end
