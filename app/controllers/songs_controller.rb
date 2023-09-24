class SongsController < ApplicationController
  require 'r2_client.rb'
  def index;
  end

  def new
    @song = Song.new
  end

  def create
    response = R2Client.upload(params[:song][:file], params[:song][:name])
    if response.successful?
      # create the song record
    else
      render :new
    end
  end


  private
  def song_params
    params.require(:song).permit(:file, :name)
  end
end
