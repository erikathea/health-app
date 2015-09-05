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
end
