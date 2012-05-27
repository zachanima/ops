module OperationsHelper
  def pilots_by_activity activities
    activities.collect do |activity|
      content_tag :span, :class =>
        if activity.operated
          if activity.prepared
            'operated prepared'
          else
            'operated'
          end
        else
          'prepared'
        end do
        h activity.pilot.first_name
      end
    end * ', '
  end
end
