require('capybara/rspec')
require('./app')
require "spec_helper"

Capybara.app = Sinatra::Application
set(:show_exceptions,false)

describe("viewing and adding doctors", {:type => :feature}) do
  it("processes user input to add a doctor to the doctors list") do
    visit("/doctors/new")
    fill_in("name", :with => "John")
    fill_in("specialty", :with => "Ophthalmology")
    click_button("submit")
    expect(page).to have_content("John")
  end
end

describe("viewing and adding patients", {:type => :feature}) do
  it("processes user input to add a doctor to the doctors list") do
    visit("patients/new")
    fill_in("name", :with => "Jimbo")
    fill_in("birthdate", :with => "1987-05-21")
    click_button("submit")
    expect(page).to have_content("Jimbo")
  end
end
