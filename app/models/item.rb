class Item < ActiveRecord::Base
  attr_accessible :name, :type_id, :value
end
