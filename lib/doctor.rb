class Doctor
  attr_reader :name, :specialty, :id

  def initialize(attributes)
      @id = attributes.fetch(:id)
      @name = attributes.fetch(:name)
      @specialty = attributes.fetch(:specialty)
  end

  def ==(other_doctor)
    same_name = @name == other_doctor.name
    same_specialty = @specialty == other_doctor.specialty
    same_name && same_specialty
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |doctor|
      id = doctor.fetch('id').to_i
      name = doctor.fetch('name')
      specialty = doctor.fetch('specialty')
      doctors.push(Doctor.new({:id => id, :name => name, :specialty => specialty}))
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first.fetch('id').to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM doctors WHERE id = #{id};")
    name = result.first.fetch("name")
    specialty = result.first.fetch("specialty")
    Doctor.new({:name => name, :specialty => specialty, :id => id.to_i})
  end

  def patient_add(patient_id)
    DB.exec("UPDATE patients SET doctor_id = #{@id} WHERE id = #{patient_id};")
  end

  def patients
    patients = []
    all_patients = DB.exec("SELECT * FROM patients;")
    results = DB.exec("SELECT * FROM patients WHERE doctor_id = #{@id};")
    results.each do |result|
      name = result.fetch('name')
      birthdate = result.fetch('birthdate')
      doctor_id = result.fetch('doctor_id').to_i
      id = result.fetch('id').to_i
      patients.push(Patient.new({:name => name, :id => id, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    patients
  end
end
