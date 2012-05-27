class AddImageIdToSites < ActiveRecord::Migration
  def change
    add_column :sites, :image_id, :integer
  end
end
