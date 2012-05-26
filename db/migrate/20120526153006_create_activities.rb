class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :operation
      t.references :pilot
      t.boolean :prepared
      t.boolean :operated

      t.timestamps
    end
    add_index :activities, :operation_id
    add_index :activities, :pilot_id
  end
end
