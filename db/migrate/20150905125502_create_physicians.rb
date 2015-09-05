class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.belongs_to :full_name, index: true, null: false
      t.belongs_to :contact_detail, index: true
      t.timestamps null: false
    end
  end
end
