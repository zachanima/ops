class CreateItemsSites < ActiveRecord::Migration
  def change
    create_table :items_sites, id: false do |t|
      t.references :item
      t.references :site
    end
  end
end
