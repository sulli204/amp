module ApplicationHelper
  R2_ENDPOINT = "https://#{Rails.application.credentials.dig(:cloudflare, :account_id)}.r2.cloudflarestorage.com".freeze

  def download_song(song_path)
    resp = s3_client.get_object(bucket: "amp-songs", key: song_path)
    resp
  end

  def s3_client
    Aws::S3::Client.new(
      access_key_id: Rails.application.credentials.dig(:cloudflare, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:cloudflare, :secret_access_key),
      endpoint: R2_ENDPOINT,
      region: "auto"
    )
  end
end
