class WinnerController < ApplicationController
  def index
  end

  def create
    @namearray = params[:names].to_s.split(', ').shuffle
    @num = params[:num].to_i
    @winnerarray = @namearray.shift(@num)
    p @winnerarray
  end

end
