class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def create
     @item = Item.new(item_params)
     if @item.save
       render json: @item
     else
       render json: @item.errors, status: :unprocessable_entity
     end
  end

   private
     def item_params
       params.require(:item).permit(:title, :amount, :date)
     end
end
