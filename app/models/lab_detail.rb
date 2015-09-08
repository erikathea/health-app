class LabDetail < ActiveRecord::Base
  belongs_to :lab_record
  validates :lab_record, presence: true
  validates :name, presence: true
  validates :value, presence: true

  def self.convert_details(lab_record, data)
    data.keys.each do |key|
      lab_rec = LabDetail.create(
        lab_record: lab_record,
        name: key,
        value: data[key]["value"],
        unit: data[key]["unit"],
        normal_range: data[key]["normal_range"]
      )
    end
  end
end
