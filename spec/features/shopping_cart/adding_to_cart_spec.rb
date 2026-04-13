require "rails_helper"

RSpec.describe "adding to cart" do
  let(:buyer) { User.create(email: "buyer@example.com", password: "password") }
  let(:summer_night) { Event.create(name: "A Midsummer Night's Dream") }
  let(:romeo) { Event.create(name: "Romeo and Juliett") }
  let(:first_performance) { summer_night.performances.create(start_time: "2018-02-08 19:00:00") }
  let(:next_performance) { summer_night.performances.create(start_time: "2018-02-09 19:00:00") }

  before do
    [first_performance, next_performance].each do |perf|
      2.times { perf.tickets.create(price_cents: 1500, status: "unsold") }
    end
  end

  it "adds a performance to a cart", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
    login_as(buyer, scope: :user)
    visit event_path(summer_night)

    within("#performance_#{first_performance.id}") do
      select("2", from: "ticket_count")
      click_on("add-to-cart")
    end

    expect(current_url).to match("cart")

    within("#event_#{summer_night.id}") do
      within("#performance_#{first_performance.id}") do
        expect(page).to have_selector(".ticket_count", text: "2")
        expect(page).to have_selector(".subtotal", text: "$30")
      end

      expect(page).not_to have_selector("#22-06-1600")
      expect(page).not_to have_selector("#event_#{romeo.id}")
    end
  end
end
