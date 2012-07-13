class RenameOperationsTaxToTaxRate < ActiveRecord::Migration
  def change
    rename_column :operations, :tax, :tax_rate
  end
end
