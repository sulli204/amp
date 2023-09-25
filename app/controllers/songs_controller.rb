require "aws-sdk-s3"

class SongsController < ApplicationController
  def index;# feed page
  end

  def new
    @song = Song.new
  end

  # current_user's page
  def collection
    @user = User.where(profile_page: params[:profile_page]).first
    @songs = Song.where(user_id: @user.id)
  end

  def create
    if !params[:song][:file_path].content_type.include?("audio")
      flash[:alert] = "Please upload an audio file"
      return
    end

    response = upload(params[:song][:file_path], params[:song][:name])
    if response.successful?
      params[:song][:file_path] = create_file_path(params[:song][:name])
      @song = Song.new(song_params)

      if @song.save
        flash[:notice] = "Song #{params[:song][:name]} has been uploaded!"
        redirect_to root_path
      else
        render :new
      end
    else
      render :new
    end
  end


  private
  def song_params
    params.require(:song).permit(:file_path, :name, :user_id)
  end

  R2_ENDPOINT = "https://#{Rails.application.credentials.dig(:cloudflare, :account_id)}.r2.cloudflarestorage.com".freeze

  def s3_client
    Aws::S3::Client.new(
      access_key_id: Rails.application.credentials.dig(:cloudflare, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:cloudflare, :secret_access_key),
      endpoint: R2_ENDPOINT,
      region: "auto"
    )
  end

  def upload(file, name)
    s3 = s3_client
    resp = ""

    File.open(file, 'rb') do |f|                     # Needs to be something unique to user (i.e. profile_page)
      resp = s3.put_object(bucket: "amp-songs", key: create_file_path(name), body: f)
    end
    resp
  end

  def create_file_path(name)
    params[:song][:file_path] = "users/#{current_user.profile_page}/#{name}"
  end
end
