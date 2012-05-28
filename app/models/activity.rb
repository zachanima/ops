class Activity < ActiveRecord::Base
  attr_accessible :operated, :prepared, :pilot_id

  belongs_to :operation
  belongs_to :pilot

  scope :prepared, where('prepared = ?', true)
  scope :operated, where('operated = ?', true)
end
