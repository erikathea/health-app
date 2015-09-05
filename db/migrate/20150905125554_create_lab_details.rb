class CreateLabDetails < ActiveRecord::Migration
  def change
    create_table :lab_details do |t|
      t.string :name, null:false
      t.string :value, null: false
      t.string :unit
      t.string :normal_range
      t.timestamps null: false
    end
  end
end
