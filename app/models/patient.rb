class Patient < ActiveRecord::Base
  belongs_to :full_name
  belongs_to :contact_detail
  has_many :lab_records
  has_many :physicians, through: :lab_records
  validates :ssn, uniqueness: true, presence: true, length: {is:9}
  validates :full_name, presence: true

  def name
    full_name
  end
end
