class Item < ActiveRecord::Base
  attr_accessible :name, :type_id, :value

  validates :name, uniqueness: true, presence: true
  validates :type_id, uniqueness: true, numericality: true
end
