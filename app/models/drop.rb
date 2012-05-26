class Drop < ActiveRecord::Base
  belongs_to :item
  belongs_to :operation
  attr_accessible :quantity, :item_id
end
