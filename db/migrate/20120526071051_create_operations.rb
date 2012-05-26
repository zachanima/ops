class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.references :site

      t.timestamps
    end
    add_index :operations, :site_id
  end
end
