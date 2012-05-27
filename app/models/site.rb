class Site < ActiveRecord::Base
  attr_accessible :name, :item_ids, :image_id

  has_and_belongs_to_many :items
  has_many :operations

  validates :name, uniqueness: true, presence: true
  validates :image_id, numericality: true

  default_scope order :name
end
