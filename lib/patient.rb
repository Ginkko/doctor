class Patient
  attr_reader :name, :birthdate, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id)
  end

  def ==(other_patient)
    same_name = @name == other_patient.name
    same_birthdate = @birthdate== other_patient.birthdate
    same_name && same_birthdate
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patients;")
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      birthdate = result.fetch("birthdate")
      patients.push(Patient.new({:name => name, :id => id, :birthdate => birthdate}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end
end
