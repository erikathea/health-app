class CreateHealthFacilities < ActiveRecord::Migration
  def change
    create_table :health_facilities do |t|
      t.string :name, null: false
      t.belongs_to :contact_detail, index: true
      t.timestamps null: false
    end
  end
end
