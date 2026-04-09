require "rails_helper"

RSpec.describe AddsToCart do
  let(:user) { instance_double(User) }
  let(:performance) { instance_double(Performance) }
  let(:ticket_one) { instance_spy(Ticket, status: "unsold") }
  let(:ticket_two) { instance_spy(Ticket, status: "unsold") }

  describe "happy path adding tickets" do
    let(:action) { described_class.new(user: user, performance: performance, count: 1) }

    before do
      allow(performance).to receive(:unsold_tickets).and_return([ticket_one])
      action.run
    end

    it "calls #unsold_tickets of the performance" do
      expect(performance).to have_received(:unsold_tickets).with(1)
    end

    it "succeeds" do
      expect(action.success).to be true
    end

    it "adds a ticket to a cart", :aggregate_failures do
      expect(ticket_one).to have_received(:place_in_cart_for).with(user)
      expect(ticket_two).not_to have_received(:place_in_cart_for)
    end
  end

  describe "if there are no tickets, the action fails" do
    let(:action) { described_class.new(user: user, performance: performance, count: 1) }

    before do
      allow(performance).to receive(:unsold_tickets).and_return([])
      action.run
    end

    it "calls the Performance#unsold_tickets method" do
      expect(performance).to have_received(:unsold_tickets).with(1)
    end

    it "does not add a ticket to the cart", :aggregate_failures do
      expect(action.success).to be false
      expect(ticket_one).not_to have_received(:place_in_cart_for)
      expect(ticket_two).not_to have_received(:place_in_cart_for)
    end
  end
end
