class Patient
  attr_reader :name, :birthdate, :id, :doctor_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  def ==(other_patient)
    same_name = @name == other_patient.name
    same_birthdate = @birthdate == other_patient.birthdate
    same_doctor_id = @doctor_id == other_patient.doctor_id
    same_name && same_birthdate && same_doctor_id
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      birthdate = result.fetch("birthdate")
      doctor_id = result["doctor_id"]
      patients.push(Patient.new({:name => name, :id => id, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM patients WHERE id = #{id};")
    name = result.first.fetch("name")
    birthdate = result.first.fetch("birthdate")
    doctor_id = result.first["doctor_id"]
    Patient.new({:name => name, :birthdate => birthdate, :id => id.to_i, :doctor_id => doctor_id})

  end
end
