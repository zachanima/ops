class OperationsController < ApplicationController
  before_filter :update_values, only: [:index, :new]
  before_filter :remove_empty_attributes, only: [:create, :update]
  before_filter :authenticate!, except: [:index, :pay]
  before_filter :authenticate_admin!, only: [:pay]

  def index
    @operations = Operation.all
    @pilots = Pilot.all
  end

  def new
    prev_activities = Operation.first.activities if Operation.first
    prev_tax_rate = Operation.first.tax_rate if Operation.first
    @operation = Operation.new
    @operation.tax_rate = prev_tax_rate.nil? ? Operation::Tax * 100 : prev_tax_rate
    Item.all.each do |item|
      @operation.drops.new item_id: item.id
    end
    Pilot.all.each do |pilot|
      prev_activity = prev_activities.where(pilot_id: pilot.id).first if prev_activities
      if prev_activity
        @operation.activities.new pilot_id: pilot.id,
          prepared: prev_activity.prepared,
          operated: prev_activity.operated
      else
        @operation.activities.new pilot_id: pilot.id
      end
    end
  end

  def edit
    @operation = Operation.find params[:id]
    items = @operation.drops.collect(&:item_id)
    pilots = @operation.activities.collect(&:pilot_id)
    Item.all.each do |item|
      @operation.drops.new item_id: item.id unless items.include? item.id
    end
    Pilot.all.each do |pilot|
      @operation.activities.new pilot_id: pilot.id unless pilots.include? pilot.id
    end
  end

  def create
    @operation = Operation.new params[:operation]
    @operation.drops.reject! do |drop|
      drop.quantity.nil?
    end
    @operation.activities.reject! do |activity|
      not activity.prepared and not activity.operated
    end
    if @operation.save
      redirect_to operations_path
    else
      render :new
    end
  end

  def update
    @operation = Operation.find params[:id]
    if @operation.update_attributes params[:operation]
      redirect_to operations_path
    else
      render :edit
    end
  end

  def pay
    Operation.all.each do |operation|
      operation.destroy
    end
    redirect_to operations_path
  end

private
  def update_values
    Item.update_values
  end

  def remove_empty_attributes
    params[:operation][:drops_attributes].each_pair do |key, value|
      if value['quantity'].to_i == 0
        Drop.destroy value['id'] if value['id']
        params[:operation][:drops_attributes].delete(key)
      end
    end
    params[:operation][:activities_attributes].each_pair do |key, value|
      if value['operated'].to_i == 0 and value['prepared'].to_i == 0
        Activity.destroy value['id'] if value['id']
        params[:operation][:activities_attributes].delete(key)
      end
    end
  end
end
