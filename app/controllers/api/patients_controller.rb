module API
  class PatientsController < ApplicationController
    before_action :authenticate, only: [:save]
    # GET /patients/1
    # GET /patients/1.json
    def show
      @patient = Patient.find_by(ssn: params[:id])
      if @patient.present?
        render json: @patient, status: 200
      else
        render nothing: true, status: 204
      end
    end

    # POST /save
    def save
      begin
        ssn = params.keys.select{ |i| i.length==9 && i.to_i > 0 }.first
        @patient = Patient.find_by(ssn: ssn)
        @patient.convert_patient_records(params[ssn])
        render json: @patient, status: 201, location: api_patient_url(id: @patient.ssn)
      rescue => e
        raise e
        render json: e, status: 422
      end
    end

    protected
      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_or_request_with_http_token do |token, options|
          key = APIKey.find_by(access_token: token)
          return false unless key
          Time.now <= (key.created_at + 5.seconds)
        end
      end

      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401
      end
  end
end
