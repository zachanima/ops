class Pilot < ActiveRecord::Base
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  default_scope order :name
end
