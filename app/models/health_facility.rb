class HealthFacility < ActiveRecord::Base
  belongs_to :contact_detail
  validates :name, presence: true, uniqueness: true
end
