require "aws-sdk-s3"

module R2Client
  R2_ENDPOINT = "https://#{Rails.application.credentials.dig(:cloudflare, :account_id)}.r2.cloudflarestorage.com".freeze

  def self.client
    Aws::S3::Client.new(
      access_key_id: Rails.application.credentials.dig(:cloudflare, :access_key_id),
      secret_access_key: Rails.application.credentials.dig(:cloudflare, :secret_access_key),
      endpoint: R2_ENDPOINT,
      region: "auto"
    )
  end

  def self.upload(file, name)
    s3 = self.client
    resp = ""

    File.open(file, 'rb') do |f|
      resp = s3.put_object(bucket: "amp-songs", key: name, body: f)
    end
    resp
  end
end