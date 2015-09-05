class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.belongs_to :full_name, index: true, null: false
      t.belongs_to :contact_detail, index: true
      t.string :ssn, limit:9, null: false
      t.date :registration_date
      t.timestamps null: false
    end
  end
end
