class TempConverterController < ApplicationController
  def index
     if params[:temp] != ""
       if params[:temp] == "corf_farenheit"
        @original = params[:temp].to_i
        @converted = (@original * 1.8)+32
      else
        @original = params[:temp].to_i
        @converted = (@original-32)/1.8
      end
    end
  end
end
