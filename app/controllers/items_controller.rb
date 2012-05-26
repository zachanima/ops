class ItemsController < ApplicationController
  def new
    @item = Item.new
    @items = Item.all
  end

  def create
    @item = Item.new params[:item]
    if @item.save
      redirect_to new_item_path
    else
      render :new
    end
  end
end
