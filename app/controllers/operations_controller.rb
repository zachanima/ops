class OperationsController < ApplicationController
  def index
    @operations = Operation.all
    @pilots = Pilot.all
  end

  def new
  end
end
