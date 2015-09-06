class FullName < ActiveRecord::Base
  def to_s
    "#{first_name} #{middle_name} #{last_name} #{suffix}"
  end
end
