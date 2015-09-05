class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.string :address
      t.string :email
      t.string :landline
      t.string :mobile
      t.string :fax
      t.timestamps null: false
    end
  end
end
