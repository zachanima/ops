class Pilot < ActiveRecord::Base
  attr_accessible :name

  validates :name, uniqueness: true, presence: true

  has_many :activities, dependent: :destroy
  has_many :operations, through: :activities

  default_scope order :name

  def first_name
    self.name.split[0]
  end

  def total
    self.operations.collect do |operation|
      [operation.preparing(self), operation.operating(self)]
    end.flatten.compact.inject(&:+) or 0.(0
  end
end
