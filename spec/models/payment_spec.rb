require "rails_helper"

RSpec.describe Payment, type: :model do
  describe ".generate_reference" do
    before do
      allow(SecureRandom).to receive(:hex).and_return("first", "second")
    end

    it "generates a reference" do
      expect(described_class.generate_reference).to eq("first")
    end

    it "avoids duplications" do
      create(:payment, reference: "first", user: create(:user))
      expect(described_class.generate_reference).to eq("second")
    end
  end
end
