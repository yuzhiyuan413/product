class OrdersController < ApplicationController
	def index
		@orders = Order.by_user_id(current_user.id)
	end

	def new
    @order = Order.new
  end

  def show 
  end
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to user_orders_path(current_user), notice: '' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  private

    def order_params
      params.require(:order).permit(:name, :status)
    end

end
