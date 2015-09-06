require 'spec_helper'

describe API::PatientsController, type: :controller do

  describe 'GET #show' do
    before(:each) do
      @patient = create(:patient)
      get :show, id: @patient.ssn, format: :json
    end

    it 'return success response' do
      expect(response).to be_success
    end

    it 'shows a patient card' do
      json = JSON.parse(response.body, symbolize_name: true)
      expect(json['ssn']).to eq(@patient.ssn)
    end
  end
end