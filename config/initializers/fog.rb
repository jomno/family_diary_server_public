CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"                        # required
  config.fog_credentials = {
    provider: "AWS",                        # required
    aws_access_key_id: Rails.application.credentials.dig(:aws_access_key_id), # required
    aws_secret_access_key: Rails.application.credentials.dig(:aws_secret_access_key), # required
    region: "ap-northeast-2",             # optional, defaults to 'us-east-1'
  }

  config.fog_directory = Rails.application.credentials.dig(:aws_bucket_name)
  # config.asset_host = Rails.application.credentials.config.dig(Rails.env.to_sym, :asset_host)
end
