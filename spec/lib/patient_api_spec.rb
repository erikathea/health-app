require 'spec_helper'

describe 'Patient API' do
  it 'shows a patient card' do
    patient = create(:patient)
    get "api/patients/#{patient.ssn}"
    expect(response).to be_success
    expect(json['ssn']).to eq(patient.ssn)
  end
end