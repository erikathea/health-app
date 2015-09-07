class LabRecord < ActiveRecord::Base
  belongs_to :patient
  belongs_to :physician
  belongs_to :health_facility
  has_many :lab_details
  validates :patient, presence: true
  validates :physician, presence: true
  validates :health_facility, presence: true
  validates :name, presence: true
  validates :date_conducted, presence: true

  def self.convert_records(patient, data)
    data.keys.each do |key|
      @health_facility = HealthFacility.find_or_create_by(name: data[key]["location"])
      @physician = Physician.find_or_create_by_full_name(data[key]["physician"])
      lab_record = LabRecord.create(
        name: key,
        patient: patient,
        physician: @physician,
        health_facility: @health_facility,
        date_conducted: data[key]["date"]
      )
      LabDetail.convert_details(lab_record, data[key]["data"])
    end
  end
end
