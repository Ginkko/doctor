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

describe("adding a patient to a doctor", {:type => :feature}) do
  it("show a patient's details and list of doctors. On selecting doctor and clicking submit, display patient on doctor detail list") do
    test_doctor = Doctor.new({:name => "John", :specialty => "Proctology", :id => nil})
    test_patient = Patient.new({:name => "Sally", :birthdate => "1990-05-21", :id => nil, :doctor_id => nil})
    test_doctor.save
    test_patient.save
    visit("/patients/#{test_patient.id}")
    select test_doctor.name, from: "doctors"
    click_button("submit")
    expect(page).to have_content(test_patient.name)
  end
end
