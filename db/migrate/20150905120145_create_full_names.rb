class CreateFullNames < ActiveRecord::Migration
  def change
    create_table :full_names do |t|
      t.string :first_name, limit: 30, null: false
      t.string :middle_name, limit: 30, null: false
      t.string :last_name, limit: 30, null: false
      t.string :title, limit: 10
      t.string :prefix, limit: 10
      t.string :suffix, limit: 10
      t.string :nickname, limit: 10
      t.timestamps null: false
    end
  end
end
