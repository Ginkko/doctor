require "spec_helper"

describe(Doctor) do
  describe("#save") do
    it("adds a doctor to the doctors table") do
      test_doctor = Doctor.new({:name => "John", :specialty => "Proctology", :id => nil})
      test_doctor.save
      expect(Doctor.all).to(eq([test_doctor]))
    end
  end

  describe(".find") do
    it("returns a doctor with the given id") do
      test_doctor = Doctor.new({:name => "John", :specialty => "Proctology", :id => nil})
      test_doctor.save
      expect(Doctor.find(test_doctor.id)).to eq(test_doctor)
    end
  end

  describe("#patient_add") do
    it("update the patient's doctor_id with the mathcing doctor's id") do
      test_doctor = Doctor.new({:name => "John", :specialty => "Proctology", :id => nil})
      test_patient = Patient.new({:name => "Sally", :birthdate => "1990-05-21", :id => nil, :doctor_id => nil})
      test_doctor.save
      test_patient.save
      test_doctor.patient_add(test_patient.id)
      expect(Patient.find(test_patient.id).doctor_id.to_i).to eq(test_doctor.id)
    end
  end


end
