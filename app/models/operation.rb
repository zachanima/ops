class Operation < ActiveRecord::Base
  attr_accessible :site_id, :drops_attributes, :activities_attributes, :tax_rate

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

  def self.total
    Operation.all.collect(&:total).inject(&:+) or 0.0
  end

  def self.tax
    Operation.all.collect(&:taxed).inject(&:+) or 0.0
  end

  def total
    unless @total
      @total = 0.0
      self.drops.each do |drop|
        @total += drop.item.value * drop.quantity if drop.quantity
      end
    end
    @total
  end

  def taxed
    self.total * self.tax_rate / 100.0
  end


  def preparing pilot
    if self.tax_rate == 100
      return 0.0
    end
    if self.activities.prepared.collect(&:pilot).include? pilot
      self.total * Preparing / self.activities.prepared.count
    end
  end

  def operating pilot
    if self.tax_rate == 100
      return 0.0
    end
    operating = 1.0 - Preparing - Hauling - self.tax_rate / 100.0
    if self.activities.operated.collect(&:pilot).include? pilot
      self.total * operating / self.activities.operated.count
    end
  end

  def image
    "http://image.eveonline.com/Type/#{self.site.image_id}_32.png" if self.site.image_id
  end
end
