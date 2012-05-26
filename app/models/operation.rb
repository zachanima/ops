class Operation < ActiveRecord::Base
  attr_accessible :site_id

  validates :site_id, presence: true

  belongs_to :site
end
