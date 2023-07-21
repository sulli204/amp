class MainController < ApplicationController
  skip_before_action :authorized

  def index
  end
end