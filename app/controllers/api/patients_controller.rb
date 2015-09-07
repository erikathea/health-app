module API
  class PatientsController < ApplicationController

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

    # POST /patients
    # POST /patients.json
    def create
      @patient = Patient.new(patient_params)

      respond_to do |format|
        if @patient.save
          format.json { render :show, status: :created, location: @patient }
        else
          format.json { render json: @patient.errors, status: :unprocessable_entity }
        end
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

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_patient
        @patient = Patient.find_by(ssn: params[:ssn])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def patient_params
        permitted_params.patient_params
      end
  end
end
