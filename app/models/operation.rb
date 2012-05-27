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

  def total
    total = 0
    self.drops.each do |drop|
      total += drop.item.value * drop.quantity
    end
    total
  end

  def image
    "http://image.eveonline.com/Type/#{self.site.image_id}_32.png" if self.site.image_id
  end
end
