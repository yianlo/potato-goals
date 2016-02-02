class SessionsController < ApplicationController

  before_action only: [:new, :create] do
    redirect_to goals_url if signed_in?
  end


  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash[:errors] = ["Invalid Credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end
end
