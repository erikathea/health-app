class AddBelongsToLabRecordToLabDetail < ActiveRecord::Migration
  def change
    add_column :lab_details, :lab_record_id, :integer, index: true
  end
end
