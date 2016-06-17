class BillSplitterController < ApplicationController

  def index
  end

  def create
    @amount = params[:amount].to_f
    @tax = params[:tax].to_f
    @tip = params[:tip].to_f
    @num = params[:num].to_f
    @divide = ((@amount + (@amount * (@tax/100)) + (@amount * (@tip/100)))/@num).round(2)
    render :index
  end

end
