class Site < ActiveRecord::Base
  attr_accessible :name, :item_ids

  has_and_belongs_to_many :items
  has_many :operations

  validates :name, uniqueness: true, presence: true

  default_scope order :name
end
