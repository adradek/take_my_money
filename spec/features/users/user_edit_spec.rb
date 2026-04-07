require "rails_helper"

RSpec.feature "User edit", :devise do
  scenario "user changes email address" do # rubocop:disable RSpec/ExampleLength
    user = FactoryBot.create(:user)
    sign_in(user.email, user.password)

    visit edit_user_registration_path(user)
    fill_in "Email", with: "newmail@example.com"
    fill_in "Current password", with: user.password
    click_button "Update"

    txts = %w[updated update_needs_confirmation].map { |status| I18n.t("devise.registrations.#{status}") }
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  scenario "user cannot edit another user's profile", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
    user = FactoryBot.create(:user)
    another_user = FactoryBot.create(:user, email: "other@example.com")

    sign_in(user.email, user.password)
    visit edit_user_registration_path(another_user)

    expect(page).to have_content("Edit User")
    expect(page).to have_field("Email", with: user.email)
  end
end
