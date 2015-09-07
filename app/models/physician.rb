class Physician < ActiveRecord::Base
  belongs_to :full_name
  belongs_to :contact_detail
  validates :full_name, presence: true

  def self.find_or_create_by_full_name(query)
    physician = Physician.find_by_full_name(query)
    return physician.first unless physician.empty?
    Physician.create(
      full_name: FullName.insert_full_name(query)
    )
  end

  def self.find_by_full_name(query)
    full_name = FullName.find_by_full_name(query)
    where(full_name: full_name)
  end
end
