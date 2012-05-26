class Activity < ActiveRecord::Base
  belongs_to :operation
  belongs_to :pilot
  attr_accessible :operated, :prepared, :pilot_id
end
