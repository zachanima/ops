class AddTaxToOperation < ActiveRecord::Migration
  def change
    add_column :operations, :tax, :float
  end
end
