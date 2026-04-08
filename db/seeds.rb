# frozen_string_literal: true

# Seed data for "Shakespeare on Ice" theater, Anchorage, Alaska

$stdout.puts "Cleaning database..."

Ticket.delete_all
Performance.delete_all
Event.delete_all
User.delete_all

# Users
$stdout.puts "Creating users..."

admin = User.create!(
  name: "Nancy Barrow",
  email: "admin@example.com",
  password: "password123"
)

users = User.create!([
  { name: "Jack London", email: "jack@iditarod.ak", password: "password123" },
  { name: "Sarah Palin", email: "sarah@wasilla.ak", password: "password123" },
  { name: "Peter Tromsø", email: "peter@fairbanks.ak", password: "password123" },
  { name: "Mary Klondike", email: "mary@juneau.ak", password: "password123" }
])

# Events (Shakespeare plays)
$stdout.puts "Creating events..."

events = Event.create!([
  {
    name: "Hamlet on Ice",
    description: "To be or not to be — that is the question when it's -40°C outside. " \
      "The classic tragedy performed by a troupe on skates. " \
      "The ghost of Hamlet's father emerges from the mist over frozen Cook Inlet.",
    image_url: "https://example.com/hamlet-on-ice.jpg"
  },
  {
    name: "A Midsummer Night's Dream in Alaska",
    description: "When the June sun never sets, the fairies of Oberon and Titania " \
      "frolic under the midnight sun among the birches of Denali. " \
      "A magical comedy featuring a live bear (not real).",
    image_url: "https://example.com/midsummer-alaska.jpg"
  },
  {
    name: "Macbeth in the Tundra",
    description: "Three witches brew their potion in a cauldron at the foot of Denali. " \
      "A bloody tale of power and betrayal set against the permafrost. " \
      "Do not speak the name of this play inside an igloo!",
    image_url: "https://example.com/macbeth-tundra.jpg"
  },
  {
    name: "Romeo & Juliet: Two Anchorage Clans",
    description: "A family of salmon fishermen against a family of moose hunters. " \
      "The timeless love story unfolding beneath the Northern Lights. " \
      "The balcony scene has been replaced with the roof of a snowmobile.",
    image_url: "https://example.com/romeo-juliet-anchorage.jpg"
  },
  {
    name: "The Tempest in the Bering Sea",
    description: "Prospero is a former captain of a crab fishing vessel, " \
      "washed ashore on Kodiak Island. Ariel is a sea otter with magical powers. " \
      "The show goes on in real bad weather.",
    image_url: "https://example.com/tempest-bering.jpg"
  }
])

# Performances (upcoming shows in spring-summer 2026)
$stdout.puts "Creating performances..."

hamlet, midsummer, macbeth, romeo, tempest = events

performances = []

# Hamlet - 3 performances
performances += Performance.create!([
  { event: hamlet, start_time: Time.zone.parse("2026-05-01 19:00"), end_time: Time.zone.parse("2026-05-01 22:00") },
  { event: hamlet, start_time: Time.zone.parse("2026-05-08 19:00"), end_time: Time.zone.parse("2026-05-08 22:00") },
  { event: hamlet, start_time: Time.zone.parse("2026-05-15 19:00"), end_time: Time.zone.parse("2026-05-15 22:00") }
])

# Midsummer - 4 performances (summer solstice run)
performances += Performance.create!([
  { event: midsummer, start_time: Time.zone.parse("2026-06-19 23:00"), end_time: Time.zone.parse("2026-06-20 02:00") },
  { event: midsummer, start_time: Time.zone.parse("2026-06-20 23:00"), end_time: Time.zone.parse("2026-06-21 02:00") },
  { event: midsummer, start_time: Time.zone.parse("2026-06-21 23:00"), end_time: Time.zone.parse("2026-06-22 02:00") },
  { event: midsummer, start_time: Time.zone.parse("2026-06-22 23:00"), end_time: Time.zone.parse("2026-06-23 02:00") }
])

# Macbeth - 2 performances
performances += Performance.create!([
  { event: macbeth, start_time: Time.zone.parse("2026-07-04 20:00"), end_time: Time.zone.parse("2026-07-04 23:00") },
  { event: macbeth, start_time: Time.zone.parse("2026-07-11 20:00"), end_time: Time.zone.parse("2026-07-11 23:00") }
])

# Romeo & Juliet - 3 performances
performances += Performance.create!([
  { event: romeo, start_time: Time.zone.parse("2026-08-01 18:00"), end_time: Time.zone.parse("2026-08-01 21:00") },
  { event: romeo, start_time: Time.zone.parse("2026-08-08 18:00"), end_time: Time.zone.parse("2026-08-08 21:00") },
  { event: romeo, start_time: Time.zone.parse("2026-08-15 18:00"), end_time: Time.zone.parse("2026-08-15 21:00") }
])

# The Tempest - 2 performances
performances += Performance.create!([
  { event: tempest, start_time: Time.zone.parse("2026-09-05 19:00"), end_time: Time.zone.parse("2026-09-05 22:00") },
  { event: tempest, start_time: Time.zone.parse("2026-09-12 19:00"), end_time: Time.zone.parse("2026-09-12 22:00") }
])

# Tickets
$stdout.puts "Creating tickets..."

performances.each do |performance|
  # 80 general admission tickets per performance at $45
  80.times do
    Ticket.create!(
      performance: performance,
      status: :unsold,
      access: :general,
      price_cents: 4500,
      price_currency: "USD"
    )
  end
end

# Assign a few tickets to users (already purchased / in cart)
first_perf = performances.first
waiting_tickets = first_perf.tickets.unsold.limit(3).to_a

waiting_tickets[0].update!(status: :waiting, user: users[0])
waiting_tickets[1].update!(status: :waiting, user: users[1])
waiting_tickets[2].update!(status: :waiting, user: admin)

$stdout.puts "Done!"
$stdout.puts "  #{User.count} users"
$stdout.puts "  #{Event.count} events"
$stdout.puts "  #{Performance.count} performances"
$stdout.puts "  #{Ticket.count} tickets (#{Ticket.waiting.count} in cart)"
