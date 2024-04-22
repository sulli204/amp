class SessionsController < ApplicationController
  skip_before_action :authorized

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      flash[:alert] ? "" : ""
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "Incorrect email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "You've been logged out"
    redirect_to root_path
  end
end
