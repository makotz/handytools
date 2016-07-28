class CallbacksController < ApplicationController

  def twitter
    twitter_data = request.env['omniauth.auth']
    user = User.create_from_twitter twitter_data
    sign_in(user)
    redirect_to root_path, notice: "Signed in with Facebook! Welcome back, #{user.first_name}"
  end

end
