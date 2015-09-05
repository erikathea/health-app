class CreateLabRecords < ActiveRecord::Migration
  def change
    create_table :lab_records do |t|
      t.belongs_to :patient, index: true, null: false
      t.belongs_to :physician, index: true, null: false
      t.belongs_to :health_facility, index: true, null: false
      t.string :name, null: false
      t.datetime :date_conducted, null: false
      t.timestamps null: false
    end
  end
end
