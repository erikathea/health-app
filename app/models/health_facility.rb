class HealthFacility < ActiveRecord::Base
  belongs_to :contact_detail
  validates :name, presence: true, uniqueness: true
  before_validation do
    self.name = name.titleize
  end
end
