class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
    end
  end
end
