class CreatePilots < ActiveRecord::Migration
  def change
    create_table :pilots do |t|
      t.string :name
    end
  end
end
