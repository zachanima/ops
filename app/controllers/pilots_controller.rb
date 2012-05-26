class PilotsController < ApplicationController
  def new
    @pilot = Pilot.new
    @pilots = Pilot.all
  end

  def create
    @pilot = Pilot.new params[:pilot]
    if @pilot.save
      redirect_to new_pilot_path
    else
      @pilots = Pilot.all
      render :new
    end
  end
end
