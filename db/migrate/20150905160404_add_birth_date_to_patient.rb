class AddBirthDateToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :birth_date, :date
  end
end
