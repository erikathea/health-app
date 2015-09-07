class PermittedParams < Struct.new(:params)
  def patient_params
    params.require(:patient).permit(*patient_attributes)
  end

  def patient_attributes
    [
      :ssn,
      :gender,
      :birth_date,
      :full_name => full_name_attributes,
      :contact_detail => contact_detail_attributes
    ]
  end

  def full_name_attributes
    [
      :first_name,
      :middle_name,
      :last_name,
      :prefix,
      :suffix,
      :title,
      :nickname
    ]
  end

  def contact_detail_attributes
    [
      :address
      :email
      :landline
      :mobile
      :fax
    ]
  end
end