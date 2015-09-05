class Physician < ActiveRecord::Base
  belongs_to :full_name
  belongs_to :contact_detail
  validates :full_name, presence: true
end
