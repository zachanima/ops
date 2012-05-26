class OperationsController < ApplicationController
  def index
    @operations = Operation.all
    @pilots = Pilot.all
  end

  def new
    @operation = Operation.new
    Item.all.each do |item|
      @operation.drops.new item_id: item.id
    end
  end

  def create
    @operation = Operation.new params[:operation]
    @operation.drops.reject! do |drop|
      drop.quantity.nil?
    end
    if @operation.save
      redirect_to operations_path
    else
      render :new
    end
  end
end
