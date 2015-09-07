class FullName < ActiveRecord::Base

  def self.find_by_full_name(query)
    result = FullName.where("(first_name ||' '|| middle_name ||' '|| last_name ||' '|| suffix) LIKE ?", "%#{query}")
    result.empty? ? nil : result
  end

  def self.insert_full_name(query)
    #Note: The result may not be accurate
    name = query.split(' ', 4)
    FullName.create(
      first_name: name[0],
      middle_name: name[1],
      last_name: name[2],
      suffix: name[3]
    )
  end

  def to_s
    "#{first_name} #{middle_name} #{last_name} #{suffix}".strip
  end
end
