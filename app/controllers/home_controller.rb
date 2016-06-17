class HomeController < ApplicationController
  #methods defined in controllers are called 'actions'

  def index
  end

  def greet
    # we can use symbols or stirngs to access values in the 'params' hash
    @name = params[:name]

  end

  def about
    # This tells Rails to look for a file: /app/views/home/about/html.erb it will render the file and send it as a response.
    #layout: applicaiton tells Rails to use:
    #/app/views/layouts/application.html.erb
    # render :about, layout: "application"
    # The line above is a Rails convention and is reflective of the opinionated ruby structure

  end
end
