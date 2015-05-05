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
end
