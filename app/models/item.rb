require 'net/http'
require 'rexml/document'

class Item < ActiveRecord::Base
  attr_accessible :name, :type_id, :value

  has_and_belongs_to_many :sites
  has_many :drops
  has_many :operations, through: :drops

  validates :name, uniqueness: true, presence: true
  validates :type_id, uniqueness: true, numericality: true

  default_scope order :name
  scope :outdated, where('updated_at < ? or value is null', Time.now - 2.hours).limit(50)

  def self.update_values
    items = Item.outdated.collect(&:type_id)
    return if items.empty?

    url = [
      'http://api.eve-central.com/api/marketstat?typeid=',
      items.join('&typeid='), '&usesystem=30000142'
    ].join

    buy = Array.new
    data = Net::HTTP.get_response(URI.parse(url)).body
    elements = REXML::Document.new(data).elements
    elements.each('/evec_api/marketstat/type/buy/max') do |item|
      buy << item.to_s.gsub(/[^0-9\.]/, '').to_f
    end

    buy.each_index do |i|
      item = Item.find_by_type_id(items[i])
      item.value = buy[i]
      item.save
      item.touch
    end
  end
end
