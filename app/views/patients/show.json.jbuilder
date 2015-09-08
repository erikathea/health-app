json.ssn @patient.ssn
json.(@patient.full_name, :first_name, :middle_name, :last_name)

json.records @patient.lab_records, :name
