require "spec_helper"

describe(Patient) do
  describe("#save") do
    it("adds a patient to the patients table") do
      test_patient = Patient.new({:name => "Sally", :birthdate => "1990-05-21", :id => nil, :doctor_id => nil})
      test_patient.save
      expect(Patient.all).to(eq([test_patient]))
    end
  end
end
