require "./lib/doctor"
require "./lib/patient"
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require "pg"

DB = PG.connect({:dbname => "doctor"})

get('/') do
  erb(:index)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

post('/doctors') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  Doctor.new({:name => name, :specialty => specialty, :id => nil}).save
  @doctors = Doctor.all()
  erb(:doctors)
end

get('/doctors/new') do
  erb(:doctor_add)
end

get('/patients') do
  erb(:patients)
end

post('/patients') do
  name = params.fetch('name')
  birthdate = params.fetch('birthdate')
  Patient.new({:name => name, :birthdate => birthdate, :id => nil, :doctor_id => nil}).save
  @patients = Patient.all()
  erb(:patients)
end

get('/patients/new') do
  erb(:patient_add)
end
