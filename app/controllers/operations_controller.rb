class OperationsController < ApplicationController
  def index
    @operations = Operation.all
    @pilots = Pilot.all
  end

  def new
    @operation = Operation.new
    @items = Item.all
  end
end
