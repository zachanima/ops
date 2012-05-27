class Operation < ActiveRecord::Base
  attr_accessible :site_id, :drops_attributes, :activities_attributes

  validates :site_id, presence: true

  belongs_to :site
  has_many :drops, dependent: :destroy
  has_many :items, through: :drops
  has_many :activities, dependent: :destroy
  has_many :pilots, through: :activities

  accepts_nested_attributes_for :drops, :activities

  default_scope order('id desc')

  # Activity percentages.
  Preparing = 0.1
  Operating = 0.75
  Hauling = 0.05
  Tax = 0.1

  def self.hauling
    Operation.total * Hauling
  end

  def self.tax
    Operation.total * Tax
  end

  def self.total
    Operation.all.collect(&:total).inject(&:+) or 0.0
  end

  def total
    total = 0.0
    self.drops.each do |drop|
      total += drop.item.value * drop.quantity if drop.quantity
    end
    total
  end

  def image
    "http://image.eveonline.com/Type/#{self.site.image_id}_32.png" if self.site.image_id
  end
end
