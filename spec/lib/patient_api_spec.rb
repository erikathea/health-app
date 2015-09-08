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

  describe 'POST #save without TOKEN', :type => :api do
    context 'when token is not present' do
      before(:each) do
        @patient = create(:patient)
        @lab_record_1 = create(:lab_record, patient: @patient)
        @lab_record_2 = create(:lab_record, patient: @patient)
        @lab_detail_1 = create(:lab_detail, lab_record: @lab_record_1)
        @lab_detail_2 = create(:lab_detail, lab_record: @lab_record_1, normal_range: "0-10", unit: "u")
        @lab_detail_3 = create(:lab_detail, lab_record: @lab_record_2)
        post :save, payload,
          {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s}
      end

      it 'returns unauthorized response' do
        expect(response.status).to eq(401)
      end

      it 'shows a patient card' do
        expect(response.body.strip).to eq('HTTP Token: Access denied.')
      end
    end
  end

  describe 'POST #save with TOKEN', :type => :api do
    context 'when token is invalid' do
      before(:each) do
        @patient = create(:patient)
        @lab_record_1 = create(:lab_record, patient: @patient)
        @lab_record_2 = create(:lab_record, patient: @patient)
        @lab_detail_1 = create(:lab_detail, lab_record: @lab_record_1)
        @lab_detail_2 = create(:lab_detail, lab_record: @lab_record_1, normal_range: "0-10", unit: "u")
        @lab_detail_3 = create(:lab_detail, lab_record: @lab_record_2)
        post :save, payload,
          {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => 'fake'}
      end

      it 'returns unauthorized response' do
        expect(response.status).to eq(401)
      end

      it 'shows a patient card' do
        expect(response.body.strip).to eq('HTTP Token: Access denied.')
      end
    end

    context 'when token is expired' do
      before(:each) do
        @patient = create(:patient)
        @lab_record_1 = create(:lab_record, patient: @patient)
        @lab_record_2 = create(:lab_record, patient: @patient)
        @lab_detail_1 = create(:lab_detail, lab_record: @lab_record_1)
        @lab_detail_2 = create(:lab_detail, lab_record: @lab_record_1, normal_range: "0-10", unit: "u")
        @lab_detail_3 = create(:lab_detail, lab_record: @lab_record_2)
        api_key = create(:api_key)
        api_key.update(created_at: api_key.created_at - 10.seconds)
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
        post :save, payload,
          {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => 'fake'}
      end

      it 'returns unauthorized response' do
        expect(response.status).to eq(401)
      end

      it 'shows a patient card' do
        expect(response.body.strip).to eq('HTTP Token: Access denied.')
      end
    end

    context 'when adding valid data to patient' do
      before(:each) do
        @patient = create(:patient)
        @lab_record_1 = create(:lab_record, patient: @patient)
        @lab_record_2 = create(:lab_record, patient: @patient)
        @lab_detail_1 = create(:lab_detail, lab_record: @lab_record_1)
        @lab_detail_2 = create(:lab_detail, lab_record: @lab_record_1, normal_range: "0-10", unit: "u")
        @lab_detail_3 = create(:lab_detail, lab_record: @lab_record_2)
        api_key = create(:api_key)
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
        post :save, payload,
          {
            'Accept' => Mime::JSON,
            'Content-Type' => Mime::JSON.to_s,
            'Authorization' => ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
          }
      end

      it 'returns created status' do
        expect(response.status).to eq(201)
      end

      it 'shows a patient card' do
        json = JSON.parse(response.body, symbolize_name: true)
        expect(api_patient_url(id:json['ssn'])).to eq(response.location)
      end

    end
  end

  private
  def payload
    { "#{@patient.ssn}":
      {
        "#{@lab_record_1.name}": {
          "date": "#{@lab_record_1.date_conducted.strftime('%Y-%m-%d')}",
          "location": "#{@lab_record_1.health_facility.name}",
          "physician": "#{@lab_record_1.physician.full_name}",
          "data": {
            "#{@lab_detail_1.name}": { "value": "#{@lab_detail_1.value}" },
            "#{@lab_detail_2.name}": {
              "value": "#{@lab_detail_2.value}",
              "unit": "#{@lab_detail_2.unit}",
              "normal_range": "#{@lab_detail_2.normal_range}"
            }
          }
        },
        "#{@lab_record_2.name}": {
          "date": "#{@lab_record_2.date_conducted.strftime('%Y-%m-%d')}",
          "location": "#{@lab_record_2.health_facility.name}",
          "physician": "#{@lab_record_2.physician.full_name}",
          "data": {
            "#{@lab_detail_3.name}": { "value": "#{@lab_detail_3.value}" },
          }
        }
      }
    }
  end
end