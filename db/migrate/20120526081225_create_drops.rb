class CreateDrops < ActiveRecord::Migration
  def change
    create_table :drops do |t|
      t.references :item
      t.references :operation
      t.integer :quantity

      t.timestamps
    end
    add_index :drops, :item_id
    add_index :drops, :operation_id
  end
end
