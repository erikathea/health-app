require 'spec_helper'

describe API::PatientsController, type: :controller do

  describe 'GET #show' do
    context 'when using a valid ssn' do
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

    context 'when using an invalid ssn' do
      before(:each) do
        @patient = create(:patient)
        get :show, id: @patient.id, format: :json
      end

      it 'shows nothing' do
        expect(response.body).to eq('')
      end

      it 'returns no_content response' do
        expect(response.status).to eq(204)
      end
    end
  end
end