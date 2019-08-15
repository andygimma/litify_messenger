require "rails_helper"
require "support/features/clearance_helpers"

RSpec.feature "Email" do
  scenario "logged in user creates email" do   
    subject = "important subject"
    body = "important text"

    sign_in
    visit new_email_path

    fill_in 'email_subject', with: subject
    fill_in 'email_body', with: body

    click_on 'Create Email'
    visit emails_path
    expect(page).to have_content subject
  end
end
