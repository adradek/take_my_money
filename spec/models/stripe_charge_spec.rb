require "rails_helper"

RSpec.describe StripeCharge, :vcr do
  let(:token) do
    StripeToken.new(
      credit_card_number: "4242424242424242",
      expiration_month: "12",
      expiration_year: Time.zone.now.year + 1,
      cvc: "123"
    )
  end

  let(:payment) { build_stubbed(:payment, price: Money.new(3000), reference: Payment.generate_reference) }

  # rubocop:disable RSpec/PendingWithoutReason
  xit "calls stripe to get a charge", :aggregate_failures do
    charge = described_class.charge(token: token, payment: payment)

    expect(charge.id).to start_with("ch_")
    expect(charge.amount).to eq(3000)
  end
  # rubocop:enable RSpec/PendingWithoutReason
end
