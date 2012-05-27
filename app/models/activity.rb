class Activity < ActiveRecord::Base
  attr_accessible :operated, :prepared, :pilot_id

  belongs_to :operation
  belongs_to :pilot
end
