class LabDetail < ActiveRecord::Base
  belongs_to :lab_record
  validates :lab_record, presence: true
  validates :name, presence: true
  validates :value, presence: true
end
