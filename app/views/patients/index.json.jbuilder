json.array!(@patients) do |patient|
  json.extract! patient, :id, :ssn, :registration_date
  json.name patient.full_name.to_s
  json.url patient_url(id: patient.ssn)
end
