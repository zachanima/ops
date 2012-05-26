class Pilot < ActiveRecord::Base
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  has_many :activities, dependent: :destroy
  has_many :operations, through: :activities

  default_scope order :name
end
