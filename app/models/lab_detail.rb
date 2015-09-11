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

  def remarks
    return '' unless normal_range.present?
    # assumming that the format of normal range can be:
    # operator <space> value
    # value <separator> value
    # and assuming value is always positive
    arr = normal_range.split(' ')
    return arr.length == 2 ? check_one_bound : check_both_bounds
  end

  private
  def check_one_bound
    return '' if eval("#{value} #{normal_range}") #value is within normal_range

    normal_range_array = normal_range.split(' ')
    left_bound = BigDecimal.new(normal_range.last) * BigDecimal.new("0.9")
    right_bound= BigDecimal.new(normal_range.last) * BigDecimal.new("1.1")

    # warning if within 90% - 110% of value, otherwise critical
    return (left_bound..right_bound).include?(BigDecimalDecimal.new(value)) ? 'warning' : 'critical'
  end

  def check_both_bounds
    normal_value_range = eval("#{ normal_range.gsub('-', '..')}")
    return '' if normal_value_range.include?(value) #value is within normal_range

    normal_range_array = normal_range.split('-')
    left_bound = BigDecimal.new(normal_range_array.first) * BigDecimal.new("0.9")
    right_bound = BigDecimal.new(normal_range_array.last) * BigDecimal.new("1.1")

    # warning if within 90% - 110% of value, otherwise critical
    return (left_bound..right_bound).include?(BigDecimal.new(value)) ? 'warning' : 'critical'
  end
end
