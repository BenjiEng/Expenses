class ItemsController < ApplicationController

  def index
    @items = current_user.items
  end

  def create
     @item = Item.new(item_params)
     @item.user_id = current_user.id
     if @item.save
       render json: @item
     else
       render json: @item.errors, status: :unprocessable_entity
     end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    head :no_content
  end

   private
     def item_params
       params.require(:item).permit(:title, :amount, :date)
     end
end
