require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "#place_in_cart_for" do
    let(:user) { create(:user) }
    let(:event) { create(:event) }
    let(:performance) { create(:performance, event: event) }
    let(:ticket) { create(:ticket, status: "unsold", performance: performance) }

    it "changes ticket status" do
      ticket.place_in_cart_for(user)
      expect(ticket.status).to eq("waiting")
    end

    it "sets the user" do
      ticket.place_in_cart_for(user)
      expect(ticket.user).to eq(user)
    end
  end
end
